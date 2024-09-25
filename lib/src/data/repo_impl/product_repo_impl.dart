import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/product_data_source.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDataSource _productDataSource;
  ProductRepoImpl(this._productDataSource);
  @override
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData() async {
    final state = await _productDataSource.fetchHomeAnalyticsData();
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<List<CompanyModel>?>> fetchCompany() async {
    final state = await _productDataSource.fetchCompany();
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }
}
