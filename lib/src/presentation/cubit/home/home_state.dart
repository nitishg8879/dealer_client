part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final HomeAnalyticsDataModel data;
  HomeLoaded(this.data);
}



final class HomeHasError extends HomeState {
  final String error;
  HomeHasError(this.error);
}
