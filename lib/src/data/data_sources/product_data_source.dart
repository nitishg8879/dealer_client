import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataSource {
  Future<DataState<HomeAnalyticsDataModel?>> fetchHomeAnalyticsData() async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().homeData.get().catchError((e) => throw e);
      if (resp.docs.length == 1) {
        return DataSuccess(HomeAnalyticsDataModel.fromJson(resp.docs.first.data()));
      } else {
        throw Exception("Data not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<CategoryModel>?>> fetchCategory() async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().categories.get().catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess(resp.docs.map((e) => CategoryModel.fromJson(e.data())..id = e.id).toList());
      } else {
        throw Exception("Category not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<CompanyModel>?>> fetchCompany() async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().company.get().catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess(resp.docs.map((e) => CompanyModel.fromJson(e.data())..id = e.id).toList());
      } else {
        throw Exception("Company not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<CategoryCompanyMdoel>?>> fetchCategoryCompanyModel() async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().model.get().catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess(resp.docs.map((e) => CategoryCompanyMdoel.fromJson(e.data())..id = e.id).toList());
      } else {
        throw Exception("Category Company not found.");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  List<ProductModel> _convertJsonToList(QuerySnapshot<Map<String, dynamic>> resp) {
    return List.from(resp.docs.map((e) => ProductModel.fromJson(e.data())..id = e.id).toList());
  }

  Future<DataState<ProductModel?>> fetchProductbyId(String id) async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().product.doc(id).get().catchError((e) => throw e);
      return DataSuccess(ProductModel.fromJson(resp.data() as Map<String, dynamic>));
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<int?>> fetchProductsCount() async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().product.count().get().catchError((e) => throw e);
      return DataSuccess(resp.count);
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<ProductModel>?>> fetchProducts(
    ProductsFilterController req, {
    DocumentSnapshot? lastDocument,
    void Function(DocumentSnapshot lastdocument)? lastdoc,
  }) async {
    try {
      List<ProductModel> products = [];
      if (req.hasFilter) {
        bool hasPriceFilter = req.priceMinMaxSelected.start != 0 || req.priceMinMaxSelected.end != 0;
        bool haskmFilter = req.kmMinMaxSelected.start != 0 || req.kmMinMaxSelected.end != 0;
        bool hasyearFilter = req.minYear != null || req.maxYear != null;

        bool hasCatgeoryFilter = req.selectedCategory.isNotEmpty;
        bool hasCompanyFilter = req.selectedCompany.isNotEmpty;
        bool hasCatCmpnyFilter = req.selectedCatCompBrands.isNotEmpty;

        Query<Map<String, dynamic>>? query1, query2, query3;
        if (hasCatgeoryFilter || hasPriceFilter) {
          query1 = getIt
              .get<AppFireBaseLoc>()
              .product
              .orderBy('price')
              .where(
                'price',
                isGreaterThanOrEqualTo: req.priceMinMaxSelected.start != 0 ? req.priceMinMaxSelected.start : null,
                isLessThanOrEqualTo: req.priceMinMaxSelected.end != 0 ? req.priceMinMaxSelected.end : null,
              )
              .where(
                'category',
                whereIn: req.selectedCategory.isNotEmpty ? req.selectedCategory.map((e) => e.id).toList() : null,
              )
              .orderBy('creationDate', descending: true);
        }
        if (hasCompanyFilter || haskmFilter) {
          query2 = getIt
              .get<AppFireBaseLoc>()
              .product
              .orderBy('kmDriven')
              .where(
                'kmDriven',
                isGreaterThanOrEqualTo: req.kmMinMaxSelected.start != 0 ? req.kmMinMaxSelected.start : null,
                isLessThanOrEqualTo: req.kmMinMaxSelected.end != 0 ? req.kmMinMaxSelected.end : null,
              )
              .where(
                'company',
                whereIn: req.selectedCompany.isNotEmpty ? req.selectedCompany.map((e) => e.id).toList() : null,
              )
              .orderBy('creationDate', descending: true);
        }
        if (hasCatCmpnyFilter || hasyearFilter) {
          query3 = getIt
              .get<AppFireBaseLoc>()
              .product
              .orderBy('bikeBuyDate')
              .where(
                'bikeBuyDate',
                isGreaterThan: req.minYear == null ? null : Timestamp.fromDate(req.minYear!),
                isLessThan: req.maxYear == null ? null : Timestamp.fromDate(req.maxYear!),
              )
              .where(
                'model',
                whereIn: req.selectedCatCompBrands.isNotEmpty ? req.selectedCatCompBrands.map((e) => e.id).toList() : null,
              )
              .orderBy('creationDate', descending: true);
        }

        final resp = await Future.wait([
          if (query1 != null) query1.get(),
          if (query2 != null) query2.get(),
          if (query3 != null) query3.get(),
        ]).catchError((error) => throw error);
        for (var data in resp) {
          products.addAll(_convertJsonToList(data));
        }
      } else {
        Query<Map<String, dynamic>>? query1;
        if (lastDocument != null) {
          query1 = getIt.get<AppFireBaseLoc>().product.orderBy('creationDate', descending: true).startAfterDocument(lastDocument).limit(10);
        } else {
          query1 = getIt.get<AppFireBaseLoc>().product.orderBy('creationDate', descending: true).limit(10);
        }
        final resp = await query1.get().catchError((error) => throw error);
        products = List.from(resp.docs.map((e) => ProductModel.fromJson(e.data())..id = e.id).toList());
        if (lastdoc != null) {
          lastdoc(resp.docs.last);
        }
      }
      products = products.toSet().toList();
      return DataSuccess(products);
    } catch (e) {
      print(e.toString());
      return DataFailed(null, 204, e.toString());
    }
  }
}
