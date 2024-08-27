import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/entities/product_filter_req.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFireStore {
  final _fireStoreProductCollection = FirebaseFirestore.instance.collection('products');
  Future<List<ProductModel>> getProducts(ProductFilterReq req) async {
    QuerySnapshot<Map<String, dynamic>> data = await _fireStoreProductCollection.get();
    return data.docs
        .map(
          (e) => ProductModel.fromJson(e.data()),
        )
        .toList();
  }
}
