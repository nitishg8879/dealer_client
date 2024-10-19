import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';

abstract class OrderRepo {
  Future<String?> createOrder({required String paymentId, required ProductModel product,required String txnId});
  Future<DataState<List<OrderTransactionModel>>> fetchOrders();
  Future<DataState<String?>> cancelAndRefund({required String orderId});
}
