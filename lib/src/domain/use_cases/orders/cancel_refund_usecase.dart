import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/domain/repositories/order_repo.dart';

class CancelRefundUsecase {
  OrderRepo _orderRepo;
  CancelRefundUsecase(this._orderRepo);

  Future<DataState<String?>> call({String? orderId}) async {
    return _orderRepo.cancelAndRefund(orderId: orderId!);
  }
}
