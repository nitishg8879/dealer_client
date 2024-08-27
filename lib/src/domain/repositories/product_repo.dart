import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/entities/product_filter_req.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> getProducts(ProductFilterReq req);
  Future<ProductModel> getProductDetails(int productID);
}
