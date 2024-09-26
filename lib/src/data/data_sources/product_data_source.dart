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
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .homeData
          .get()
          .catchError((e) => throw e);
      if (resp.docs.length == 1) {
        return DataSuccess(
            HomeAnalyticsDataModel.fromJson(resp.docs.first.data()));
      } else {
        throw Exception("Data not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<CategoryModel>?>> fetchCategory() async {
    try {
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .categories
          .get()
          .catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess(resp.docs
            .map((e) => CategoryModel.fromJson(e.data())..id = e.id)
            .toList());
      } else {
        throw Exception("Category not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<CompanyModel>?>> fetchCompany() async {
    try {
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .company
          .get()
          .catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess(resp.docs
            .map((e) => CompanyModel.fromJson(e.data())..id = e.id)
            .toList());
      } else {
        throw Exception("Company not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<CategoryCompanyMdoel>?>>
      fetchCategoryCompanyModel() async {
    try {
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .model
          .get()
          .catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess(resp.docs
            .map((e) => CategoryCompanyMdoel.fromJson(e.data())..id = e.id)
            .toList());
      } else {
        throw Exception("Category Company not found.");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<ProductModel>?>> fetchProducts(
      ProductsFilterController req) async {
    try {
      req.yearMinMaxSelected;
      var query = getIt.get<AppFireBaseLoc>().product;
      query
          .where(
            "price",
            isGreaterThanOrEqualTo: req.priceMinMaxSelected.start,
          )
          .where(
            'price',
            isLessThanOrEqualTo: req.priceMinMaxSelected.end,
          )
          .where(
            "kmDriven",
            isGreaterThanOrEqualTo: req.kmMinMaxSelected.start,
          )
          .where(
            'kmDriven',
            isLessThanOrEqualTo: req.kmMinMaxSelected.end,
          )
          .where(
            'category',
            whereIn: req.selectedCategory.map((e) => e.id),
          )
          .where(
            'company',
            whereIn: req.selectedCompany.map((e) => e.id),
          )
          .where(
            'model',
            whereIn: req.selectedBrands.map((e) => e.id),
          )
          .orderBy(
            'creationDate',
            descending: true,
          )
          .limit(10);

      final resp = await getIt
          .get<AppFireBaseLoc>()
          .product
          .get()
          .catchError((e) => throw e);
      if (resp.docs.isNotEmpty) {
        return DataSuccess([]);
        // return DataSuccess(resp.docs
        //     .map((e) => CompanyModel.fromJson(e.data())..id = e.id)
        //     .toList());
      } else {
        throw Exception("Company not found");
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }
}
