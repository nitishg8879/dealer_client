import 'package:bike_client_dealer/src/data/data_sources/product_firestore.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/entities/product_filter_req.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  ProductFireStore _productFireStore = ProductFireStore();
  @override
  Future<ProductModel> getProductDetails(int productID) {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProducts(ProductFilterReq req) {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
