import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class FetchProductByIdUsecase {
  ProductRepo _productRepo;
  FetchProductByIdUsecase(this._productRepo);

  Future<DataState<ProductModel?>> call({String? id}) async {
    if (id == null) {
      throw Exception("Provide Product Id.");
    }
    return _productRepo.fetchProductbyId(id);
  }
}
