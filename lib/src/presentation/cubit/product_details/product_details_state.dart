part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel productModel;
  ProductDetailsLoaded(this.productModel);
}

final class ProductDetailsHasError extends ProductDetailsState {
  final String error;
  ProductDetailsHasError(this.error);
}

// final class ProductDetailsImagePosition extends ProductDetailsState {
//   final int total, current;
//   ProductDetailsImagePosition(this.current, this.total);
// }
