part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteError extends FavouriteState {
  final String error;
  FavouriteError(this.error);
}

final class FavouriteLoaded extends FavouriteState {
  final List<ProductModel> products;
  FavouriteLoaded(this.products);
}
