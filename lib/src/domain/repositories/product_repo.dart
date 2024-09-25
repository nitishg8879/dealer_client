import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';

abstract class ProductRepo {
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData();
  Future<DataState<List<CompanyModel>?>> fetchCompany();
  Future<DataState<List<CategoryModel>?>> fetchCategory();
}
