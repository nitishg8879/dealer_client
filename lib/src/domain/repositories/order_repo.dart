import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';

abstract class OrderRepo {
  Future<void> createOrder({required String txnId, required ProductModel product});
  Future<DataState<List<OrderTransactionModel>>> fetchOrders();
}
