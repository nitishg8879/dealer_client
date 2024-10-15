part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<OrderTransactionModel> orders;
  OrderLoaded(this.orders);
}

final class OrderError extends OrderState {
  final String errorMsg;
  OrderError(this.errorMsg);
}
