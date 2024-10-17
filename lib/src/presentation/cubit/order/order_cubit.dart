import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/orders/cancel_refund_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/orders/order_fetch_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderFetchUseCase _orderFetchUseCase;
  CancelRefundUsecase _cancelAndRefundUseCase;
  OrderCubit(this._orderFetchUseCase, this._cancelAndRefundUseCase) : super(OrderLoading());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    final data = await _orderFetchUseCase.call();
    if (data is DataSuccess) {
      emit(OrderLoaded(data.data));
    }
    if (data is DataFailed) {
      emit(OrderError(data.message ?? "Something wen't wrong."));
    }
  }

  Future<void> cancelAndRefund(String orderId) async {
    final data = await _cancelAndRefundUseCase.call(orderId: orderId);
    if (data is DataSuccess) {
      fetchOrders();
    }

    if (data is DataFailed) {
      HelperFun.showErrorSnack(data.message ?? "Something wen't wrong.");
    }
  }
}
