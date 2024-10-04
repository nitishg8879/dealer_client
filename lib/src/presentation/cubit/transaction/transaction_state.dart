part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final List<TransactionsModel> list;
  TransactionLoaded(this.list);
}

final class TransactionError extends TransactionState {
  final String error;
  TransactionError(this.error);
}
