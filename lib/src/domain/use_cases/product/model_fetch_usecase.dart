import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class ModelFetchUsecase {
  ProductRepo _productRepo;
  ModelFetchUsecase(this._productRepo);

  Future<DataState<List<CategoryCompanyMdoel>?>> call() async {
    return _productRepo.fetchCategoryCompanyModel();
  }
}