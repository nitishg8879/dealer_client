import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
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
      return DataSuccess(resp.docs.map((e) => OrderTransactionModel.fromJson(e.data())).toList());
    } catch (e) {
      return DataFailed(<OrderTransactionModel>[], 400, e.toString());
    }
  }
}
