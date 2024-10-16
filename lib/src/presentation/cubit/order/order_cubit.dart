import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/orders/order_fetch_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderFetchUseCase _orderFetchUseCase;
  OrderCubit(this._orderFetchUseCase) : super(OrderLoading());

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
}
