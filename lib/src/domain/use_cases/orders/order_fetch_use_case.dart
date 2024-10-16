import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/order_repo.dart';

class OrderFetchUseCase {
  OrderRepo _orderRepo;
  OrderFetchUseCase(this._orderRepo);

  Future<DataState<List<OrderTransactionModel>>> call() async {
    return _orderRepo.fetchOrders();
  }
}
