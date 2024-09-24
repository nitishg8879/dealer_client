import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';

abstract class ProductRepo {
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData();
}
