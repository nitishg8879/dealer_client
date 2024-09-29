import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductRepo {
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData();
  Future<DataState<List<CompanyModel>?>> fetchCompany();
  Future<DataState<List<CategoryCompanyMdoel>?>> fetchCategoryCompanyModel();
  Future<DataState<List<CategoryModel>?>> fetchCategory();
  Future<DataState<int?>> fetchProductsCount();
  Future<DataState<ProductModel?>> fetchProductbyId(String id);
  Future<DataState<List<ProductModel>?>> fetchProducts(
    ProductsFilterController req, {
    DocumentSnapshot? lastdocument,
    void Function(DocumentSnapshot lastdocument)? lastdoc,
  });
}
