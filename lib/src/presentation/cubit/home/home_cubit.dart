import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/home_analytics_fetch_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeAnalyticsFetchUsecases _productFetchUsecases;
  HomeCubit(this._productFetchUsecases) : super(HomeLoading());

  Future<void> fetchHomeAnalyticsData() async {
    emit(HomeLoading());
    await Future.delayed(Duration(seconds: 5));
    final data = await _productFetchUsecases.call();
    if (data is DataSuccess) {
      emit(HomeLoaded(data.data!));
    }
    if (data is DataFailed) {
      emit(HomeHasError(data.message ?? "Something wen't wrong"));
    }
  }

}
