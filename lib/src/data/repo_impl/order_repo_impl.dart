import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/order_data_source.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final OrderDataSource _orderDataSource;
  OrderRepoImpl(this._orderDataSource);
  @override
  Future<void> createOrder({required String txnId, required ProductModel product}) {
    return _orderDataSource.createOrder(txnId: txnId, product: product);
  }

  @override
  Future<DataState<List<OrderTransactionModel>>> fetchOrders() {
    return _orderDataSource.fetchOrders();
  }
}
