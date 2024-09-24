import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';

class ProductDataSource {
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData() async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().homeData.get().catchError((e) {
        throw e;
      });
      if (resp.docs.length == 1) {
        return DataSuccess(HomeAnalyticsDataModel.fromJson(resp.docs.first.data()));
      } else {
        throw Exception("Data not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }
}
