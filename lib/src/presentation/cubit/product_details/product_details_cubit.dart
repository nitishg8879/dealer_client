import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fetch_product_by_id_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/transaction_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final FetchProductByIdUsecase _fetchProductByIdUsecase;
  final TransactionCreateUseCase _transactionCreateUseCase;
  ProductDetailsCubit(this._fetchProductByIdUsecase, this._transactionCreateUseCase) : super(ProductDetailsLoading());
  ProductModel? productModel;

  Future<void> fetchProduct(String? id, ProductModel? product) async {
    if (kDebugMode) {
      await Future.delayed(Duration(seconds: 2));
    }
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
    emit(ProductDetailsTransactionLoading(true));
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
      label: isFail ? "Failed" : "Booked",
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
      if (!isFail) {
        
      }
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
