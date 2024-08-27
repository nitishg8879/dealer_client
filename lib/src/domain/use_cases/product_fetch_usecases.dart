import 'package:bike_client_dealer/core/util/use_cases.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/entities/product_filter_req.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class ProductFetchUsecases implements UseCase<List<ProductModel>, ProductFilterReq> {
  ProductRepo _productRepo;
  ProductFetchUsecases(this._productRepo);
  @override
  Future<List<ProductModel>> call({required ProductFilterReq params}) async {
    return _productRepo.getProducts(params);
  }
}
