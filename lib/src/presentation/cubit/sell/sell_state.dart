part of 'sell_cubit.dart';

@immutable
sealed class SellState {}

final class SellLoading extends SellState {}

final class SellLoaded extends SellState {
  final List<ProductSellModel> data;
  SellLoaded(this.data);
}
final class SellError extends SellState {
  final String errorMsg;
  SellError(this.errorMsg);
}

final class SellUploading extends SellState {
  final String? status;
  SellUploading(this.status);
}
