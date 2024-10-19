import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/order_data_source.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final OrderDataSource _orderDataSource;
  OrderRepoImpl(this._orderDataSource);
  @override
  Future<String?> createOrder({required String paymentId, required ProductModel product, required String txnId}) {
    return _orderDataSource.createOrder(paymentId: paymentId, product: product,txnId: txnId);
  }

  @override
  Future<DataState<List<OrderTransactionModel>>> fetchOrders() {
    return _orderDataSource.fetchOrders();
  }

  @override
  Future<DataState<String?>> cancelAndRefund({required String orderId}) {
    return _orderDataSource.cancelAndRefund(orderId: orderId);
  }
}
