import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
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

  Future<DataState<ProductModel?>> canBuyProduct({required String productId}) async {
    try {
      if (!getIt.get<AppLocalService>().isLoggedIn) {
        throw Exception("User not logged in");
      } else {
        final productResp = await fetchProductbyId(productId);
        if (productResp is DataSuccess) {
          if (productResp.data?.active == null || !(productResp.data!.active!)) {
            throw Exception("Product is not active");
          }
          if ((productResp.data?.sold ?? false)) {
            throw Exception("Product has been sold");
          }
          if (productResp.data?.bikeBooked ?? false) {
            throw Exception("Product has been Booked");
          }
          return DataSuccess(productResp.data);
        } else {
          throw Exception(productResp.message);
        }
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<ProductModel?>> bookProduct({required ProductModel product}) async {
    try {
      product.user ??= [];
      product.user!.add(getIt.get<AppLocalService>().currentUser!.id!);
      product.bikeBooked = true;
      product.bikeLockedTill = Timestamp.fromDate(DateTime.now().add(const Duration(hours: 24)));
      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.update(
            getIt.get<AppFireBaseLoc>().product.doc(product.id),
            {
              "bikeBooked": product.bikeBooked,
              "bikeLockedTill": product.bikeLockedTill,
              "user": product.user,
            },
          );
        },
      ).catchError((error) => throw error);
      return fetchProductbyId(product.id!);
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<ProductModel?>> fetchProductbyId(String id) async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().product.doc(id).get().catchError((e) => throw e);
      return DataSuccess(ProductModel.fromJson(resp.data() as Map<String, dynamic>)..id = resp.id);
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<bool>> addToFavourite(String productId) async {
    if (!(getIt.get<AppLocalService>().isLoggedIn) || getIt.get<AppLocalService>().currentUser?.id == null) {
      return const DataFailed(false, 500, "User is not logged in.");
    } else {
      try {
        await getIt.get<AppFireBaseLoc>().users.doc(getIt.get<AppLocalService>().currentUser!.id).update({
          'favProduct': FieldValue.arrayUnion([productId])
        }).catchError((error) {
          throw error;
        });
        return const DataSuccess(true);
      } catch (e) {
        return DataFailed(false, 500, e.toString());
      }
    }
  }

  Future<DataState<bool>> removeFromFavourite(String productId) async {
    if (!getIt.get<AppLocalService>().isLoggedIn || getIt.get<AppLocalService>().currentUser?.id == null) {
      return const DataFailed(false, 500, "User is not logged in.");
    } else {
      try {
        await getIt.get<AppFireBaseLoc>().users.doc(getIt.get<AppLocalService>().currentUser!.id).update({
          'favProduct': FieldValue.arrayRemove([productId])
        }).catchError((error) {
          throw error;
        });
        return const DataSuccess(true);
      } catch (e) {
        return DataFailed(false, 500, e.toString());
      }
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

  Future<DataState<List<ProductModel>?>> fetchProductsByIds(List<String> productsId) async {
    try {
      final resp = await getIt.get<AppFireBaseLoc>().product.where(FieldPath.documentId, whereIn: productsId).get();
      return DataSuccess(_convertJsonToList(resp));
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<ProductModel>?>> fetchProducts({
    ProductsFilterController? req,
    DocumentSnapshot? lastDocument,
    void Function(DocumentSnapshot lastdocument)? lastdoc,
  }) async {
    try {
      List<ProductModel> products = [];
      if (req != null && req.products.isNotEmpty) {
        final resp = await getIt.get<AppFireBaseLoc>().product.where(FieldPath.documentId, whereIn: req.products).get();
        products = _convertJsonToList(resp);
      } else if (req != null && req.hasFilter) {
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
          query1 = getIt
              .get<AppFireBaseLoc>()
              .product
              .orderBy(
                'creationDate',
                descending: true,
              )
              .startAfterDocument(lastDocument)
              .where('active', isEqualTo: true)
              .limit(10);
        } else {
          query1 = getIt
              .get<AppFireBaseLoc>()
              .product
              .orderBy(
                'creationDate',
                descending: true,
              )
              .where('active', isEqualTo: true)
              .limit(10);
        }
        final resp = await query1.get().catchError((error) => throw error);
        products = _convertJsonToList(resp);
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
