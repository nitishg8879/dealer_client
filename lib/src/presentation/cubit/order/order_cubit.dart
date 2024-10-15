import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderLoading());
}
