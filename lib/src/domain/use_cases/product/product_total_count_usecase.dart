import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class ProductTotalCountUsecase {
  ProductRepo _productRepo;
  ProductTotalCountUsecase(this._productRepo);

  Future<DataState<int?>> call() async {
    return _productRepo.fetchProductsCount();
  }
}
