import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/data/model/raise_dispute_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDataSource {
  Future<void> createOrder({required String txnId, required ProductModel product}) async {
    await getIt.get<AppFireBaseLoc>().order.add(
          OrderTransactionModel(
            txnId: txnId,
            userId: getIt.get<AppLocalService>().currentUser!.id!,
            createdTime: Timestamp.now(),
            validTill: product.bikeLockedTill!,
            productId: product.id ?? "-",
            status: [
              BookingStatus.Created,
            ],
          ).toJson(),
        );
  }

  Future<DataState<String?>> cancelAndRefund({required String orderId}) async {
    try {
      final data = await fetchOrderById(id: orderId);
      if (data is DataSuccess) {
        if (data.data?.status.contains(BookingStatus.Booked) ?? false) {
          throw Exception("Can't Cancel & Refund the order has been booked.");
        } else if (data.data?.status.contains(BookingStatus.CancelledByYou) ?? false) {
          throw Exception("Can't Cancel & Refund the order has been Cancelled by you.");
        } else if (data.data?.status.contains(BookingStatus.RefundIntiated) ?? false) {
          throw Exception("Can't Cancel & Refund the order has been Refunded.");
        } else {
          await getIt
              .get<AppFireBaseLoc>()
              .raiseDispute
              .add(RaiseDisputeModel(
                creationDate: Timestamp.now(),
                orderId: orderId,
                status: RaiseDisputeStatus.inProgress,
                userId: getIt.get<AppLocalService>().currentUser!.id,
                txnId: data.data?.txnId,
              ).toJson())
              .catchError((error) => throw error);
          data.data?.status.add(BookingStatus.RefundIntiated);
          await getIt.get<AppFireBaseLoc>().order.doc(orderId).update(data.data!.toJson());
          return const DataSuccess("Refund Has been Raised");
        }
      } else {
        throw Exception(data.message);
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<OrderTransactionModel?>> fetchOrderById({required String id}) async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().order.doc(id).get().catchError((error) => throw error);
      return DataSuccess(OrderTransactionModel.fromJson(resp.data() ?? {})..id = resp.id);
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<OrderTransactionModel>>> fetchOrders() async {
    if (!getIt.get<AppLocalService>().isLoggedIn || getIt.get<AppLocalService>().currentUser?.id == null) {
      return const DataFailed(<OrderTransactionModel>[], 400, "User is not logged in.");
    }
    try {
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .order
          .where(
            'userId',
            isEqualTo: getIt.get<AppLocalService>().currentUser!.id,
          )
          .orderBy(
            'createdTime',
            descending: true,
          )
          .get()
          .catchError((error) {
        throw error;
      });
      return DataSuccess(resp.docs.map((e) => OrderTransactionModel.fromJson(e.data())..id = e.id).toList());
    } catch (e) {
      return DataFailed(<OrderTransactionModel>[], 400, e.toString());
    }
  }
}
