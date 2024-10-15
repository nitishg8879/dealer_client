import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/product_data_source.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDataSource _productDataSource;
  ProductRepoImpl(this._productDataSource);
  @override
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData() async {
    final state = await _productDataSource.fetchHomeAnalyticsData();
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<List<CompanyModel>?>> fetchCompany() async {
    final state = await _productDataSource.fetchCompany();
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<List<CategoryModel>?>> fetchCategory() async {
    final state = await _productDataSource.fetchCategory();
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<List<ProductModel>?>> fetchProducts({
    ProductsFilterController? req,
    DocumentSnapshot? lastdocument,
    void Function(DocumentSnapshot lastdocument)? lastdoc,
  }) async {
    final state = await _productDataSource.fetchProducts(
      req: req,
      lastDocument: lastdocument,
      lastdoc: lastdoc,
    );
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<List<CategoryCompanyMdoel>?>> fetchCategoryCompanyModel() async {
    final state = await _productDataSource.fetchCategoryCompanyModel();
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<int?>> fetchProductsCount({
    ProductsFilterController? req,
  }) async {
    final state = await _productDataSource.fetchProductsCount(req: req);
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<ProductModel?>> fetchProductbyId(String id) async {
    final state = await _productDataSource.fetchProductbyId(id);
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<bool>> addToFavourite(String id) async {
    final state = await _productDataSource.addToFavourite(id);
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(false, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<bool>> removeFromFavourite(String id) async {
    final state = await _productDataSource.removeFromFavourite(id);
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(false, state.statusCode, state.message);
    }
  }

  @override
  Future<DataState<List<ProductModel>?>> fetchProductsByIds(List<String> ids) async {
    final state = await _productDataSource.fetchProductsByIds(ids);
    if (state is DataSuccess) {
      return state;
    } else {
      return DataFailed(null, state.statusCode, state.message);
    }
  }

  // @override
  // Future<DataState<ProductModel?>> bookProduct({required ProductModel product}) {
  //   return _productDataSource.bookProduct(product: product, txnId: '');
  // }

  @override
  Future<DataState<ProductModel?>> canBuyProduct({required String productId}) {
    return _productDataSource.canBuyProduct(productId: productId);
  }
}
