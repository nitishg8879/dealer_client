import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class CategoryCompnayFetchUsecase {
  ProductRepo _productRepo;
  CategoryCompnayFetchUsecase(this._productRepo);

  Future<DataState<List<CategoryCompanyMdoel>?>> call() async {
    return _productRepo.fetchCategoryCompanyModel();
  }
}
