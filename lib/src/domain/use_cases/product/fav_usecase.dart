import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class AddToFavouriteUseCase {
  ProductRepo _productRepo;
  AddToFavouriteUseCase(this._productRepo);

  Future<DataState<bool>> call({String? id}) async {
    if (id == null) {
      throw Exception("Provide Product Id.");
    }
    return _productRepo.addToFavourite(id);
  }
}

class RemoveFromFavouriteUsecase {
  ProductRepo _productRepo;
  RemoveFromFavouriteUsecase(this._productRepo);

  Future<DataState<bool>> call({String? id}) async {
    if (id == null) {
      throw Exception("Provide Product Id.");
    }
    return _productRepo.removeFromFavourite(id);
  }
}
