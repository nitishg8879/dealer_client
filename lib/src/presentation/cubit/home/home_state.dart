part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  HomeLoaded(this.products);
}

final class HomeHasError extends HomeState {}
