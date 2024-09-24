import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class HomeAnalyticsFetchUsecases {
  ProductRepo _productRepo;
  HomeAnalyticsFetchUsecases(this._productRepo);

  Future<DataState<HomeAnalyticsDataModel?>> call() async {
    return _productRepo.fetchHomeAnalyticsData();
  }
}
