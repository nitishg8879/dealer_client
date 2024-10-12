import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/categories/category_compnay_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/categories/category_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/categories/company_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/home_analytics_fetch_usecases.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/product_fetch_usecase.dart';
import 'package:bike_client_dealer/src/presentation/screens/auth_popup_view.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeAnalyticsFetchUsecases _productFetchUsecases;
  CompanyFetchUsecase _companyFetchUsecase;
  CategoryFetchUsecase _categoryFetchUsecase;
  CategoryCompnayFetchUsecase _categoryCompnayFetchUsecase;
  ProductFetchUsecase _productFetchUseCases;
  HomeCubit(
    this._productFetchUsecases,
    this._companyFetchUsecase,
    this._categoryFetchUsecase,
    this._categoryCompnayFetchUsecase,
    this._productFetchUseCases,
  ) : super(HomeLoading());
  HomeAnalyticsDataModel? homeData;

  Future<void> fetchHomeAnalyticsData() async {
    emit(HomeLoading());
    final resp = await Future.wait([
      _productFetchUsecases.call(),
      _companyFetchUsecase.call(),
      _categoryFetchUsecase.call(),
      _categoryCompnayFetchUsecase.call(),
      _productFetchUseCases.call(),
    ]);

    if (resp.any((a) => a is DataFailed)) {
      DataFailed? failState = resp.whereType<DataFailed>().firstOrNull;
      emit(HomeHasError(failState?.message ?? "Something wen't wrong"));
    } else {
      homeData = (resp[0].data as HomeAnalyticsDataModel?);
      homeData?.company = resp[1].data as List<CompanyModel>?;
      homeData?.category = resp[2].data as List<CategoryModel>?;
      homeData?.categoryCompnaymodel =
          resp[3].data as List<CategoryCompanyMdoel>?;
      var recentProducts = resp[4].data as List<ProductModel>?;
      HomeProducts recentItems =
          HomeProducts(label: "Recently Added", priority: 0, products: [],showFullProducts: true);
      for (var i = 0; i < 4; i++) {
        if ((recentProducts?.length ?? 0) > i) {
          recentItems.products!.add(recentProducts![i].id!);
        }
      }
      if (recentItems.products?.isNotEmpty ?? false) {
        homeData?.products?.add(recentItems);
      }
      homeData?.products?.sort((a, b) {
        return (a.priority ?? 1).compareTo(b.priority ?? 1);
      });
      emit(HomeLoaded(homeData!));
    }
  }

  void onProfileTap() {
    if (getIt.get<AppLocalService>().isLoggedIn) {
      HelperFun.goNextPage(Routes.profile);
    } else {
      AuthPopupViewDialogShow.show(
        tap: () {
          HelperFun.goNextPage(Routes.profile);
        },
      );
    }
  }
}
