import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class CategoryFetchUsecase {
  ProductRepo _productRepo;
  CategoryFetchUsecase(this._productRepo);

  Future<DataState<List<CategoryModel>?>> call() async {
    return _productRepo.fetchCategory();
  }
}