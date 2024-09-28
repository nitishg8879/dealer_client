part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductLoading extends ProductState {}

final class ProductHasError extends ProductState {
  final String errorMsg;
  ProductHasError(this.errorMsg);
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
}
