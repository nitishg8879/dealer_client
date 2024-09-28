import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';

class ProductFetchUsecase {
  ProductRepo _productRepo;
  ProductFetchUsecase(this._productRepo);

  Future<DataState<List<ProductModel>?>> call({ProductsFilterController? req}) async {
    if (req == null) {
      throw Exception("Provide req Model.");
    }
    return _productRepo.fetchProducts(req);
  }
}
