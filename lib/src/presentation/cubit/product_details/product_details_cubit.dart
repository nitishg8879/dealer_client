import 'package:bike_client_dealer/config/routes/app_routes.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/data_sources/product_data_source.dart';
import 'package:bike_client_dealer/src/data/data_sources/transaction_data_source.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fetch_product_by_id_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/transaction_usecase.dart';
import 'package:bike_client_dealer/src/presentation/screens/auth_popup_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/confirmation_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final FetchProductByIdUsecase _fetchProductByIdUsecase;
  final TransactionCreateUseCase _transactionCreateUseCase;
  ProductDetailsCubit(this._fetchProductByIdUsecase, this._transactionCreateUseCase) : super(ProductDetailsLoading()) {
    razorpay = Razorpay();
  }
  ProductModel? productModel;
  late Razorpay razorpay;

  @override
  Future<void> close() async {
    razorpay.clear();
    super.close();
  }

  Future<void> makePayment() async {
    if (!getIt.get<AppLocalService>().isLoggedIn) {
      AuthPopupViewDialogShow.show(tap: makePayment);
      return;
    }
    emit(ProductDetailsTransactionLoading(true));
    razorpay.clear();
    final resp = await getIt.get<ProductDataSource>().canBuyProduct(productId: productModel!.id!);
    if (resp is DataSuccess) {
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      var options = {
        'key': getIt.get<AppFireBaseLoc>().razorKey,
        'amount': productModel?.bookingAmount,
        'name': 'F3 Motors',
        'description': productModel?.description,
        'prefill': {
          "name": getIt.get<AppLocalService>().currentUser?.fullName,
          'contact': getIt.get<AppLocalService>().currentUser?.phoneNumber,
          'email': getIt.get<AppLocalService>().currentUser?.email,
        },
        'notes': {
          'fullName': getIt.get<AppLocalService>().currentUser?.fullName,
          "productId": productModel?.id,
          "userID": getIt.get<AppLocalService>().currentUser?.id,
        },
        'retry': {
          'enabled': false,
          'max_count': 0,
        },
        "theme": {
          "color": "#360083",
        },
      };
      razorpay.open(options);
    } else {
      emit(ProductDetailsTransactionLoading(false));
      showAlertDialog("Alert", resp.message ?? 'Something went wrong.');
      fetchProduct(productModel!.id, null);
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    razorpay.clear();
    showAlertDialog(
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
    );
    if (response.error?['metadata']['payment_id'] != null) {
      createTransaction(error: response);
    } else {
      emit(ProductDetailsTransactionLoading(false));
    }
  }

  Future<void> handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    razorpay.clear();
    createTransaction(success: response);
    final paymentStatus = await getIt.get<TransactionDataSource>().verifyPayment(paymentId: response.paymentId ?? '-');
    if (paymentStatus is DataSuccess) {
      final resp = await getIt.get<ProductDataSource>().bookProduct(product: productModel!);
      if (resp is DataSuccess) {
        fetchProduct(productModel!.id!, null);
        showAlertDialog(
          "Order Successful",
          "Payment ID: ${response.paymentId}\n\nYour order has been booked.",
        );
      }
      if (resp is DataFailed) {
        showAlertDialog(
          "Payment Successful",
          "Payment ID: ${response.paymentId}\n\nWhile booking the product we run into problem: ${resp.message}\n\n we have created your transaction id you can refund your amount, from there.",
        );
      }
    }

    if (paymentStatus is DataFailed) {
      showAlertDialog(
        "In correct Payment",
        "Payment ID: ${response.paymentId}\nThis transaction is not valid.",
      );
    }
  }

  void showAlertDialog(String title, String message) {
    showDialog(
      barrierDismissible: false,
      context: AppRoutes.rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          titleText: title,
          contentText: message,
        );
      },
    );
  }

  Future<void> fetchProduct(String? id, ProductModel? product) async {
    if (product != null) {
      emit(ProductDetailsLoaded(product));
      productModel = product;
      // emit(ProductDetailsImagePosition(1, (product.images?.length ?? 1)));
    } else {
      final resp = await _fetchProductByIdUsecase.call(id: id);
      if (resp is DataSuccess) {
        // emit(ProductDetailsImagePosition(1, (resp.data?.images?.length ?? 1)));
        emit(ProductDetailsLoaded(resp.data!));
        productModel = resp.data;
      }
      if (resp is DataFailed) {
        emit(ProductDetailsHasError(resp.message ?? "Something went wrong"));
      }
    }
  }

  Future<void> createTransaction({
    PaymentFailureResponse? error,
    PaymentSuccessResponse? success,
  }) async {
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 3));
    }
    final isFail = error != null;
    String? paymentId;
    if (isFail) {
      paymentId = error.error?['metadata']['payment_id'];
    } else {
      paymentId = success?.paymentId;
    }
    TransactionsModel txn = TransactionsModel(
      transactionsType: isFail ? TransactionsType.fail : TransactionsType.success,
      amount: productModel?.bookingAmount,
      label: isFail ? "Booking Fail" : "Booking Success",
      failedReason: isFail ? error.message : "Transaction successfully.",
      txnDateTime: Timestamp.now(),
      userId: getIt.get<AppLocalService>().currentUser?.id,
      productId: productModel?.id,
      paymentId: paymentId,
      orderId: success?.orderId,
      signature: success?.signature,
    );
    final resp = await _transactionCreateUseCase.call(txn: txn);
    if (resp is DataSuccess) {
      HelperFun.showSuccessSnack("Transaction has been created.");
      if (!isFail) {}
    }
    if (resp is DataFailed) {
      HelperFun.showSuccessSnack(resp.message ?? 'Failt to create transaction.');
    }
    emit(ProductDetailsTransactionLoading(false));
  }

  @override
  void emit(ProductDetailsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
