import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/category_compnay_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/category_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/company_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/home_analytics_fetch_usecases.dart';
import 'package:bike_client_dealer/src/presentation/screens/auth_popup_view.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeAnalyticsFetchUsecases _productFetchUsecases;
  CompanyFetchUsecase _companyFetchUsecase;
  CategoryFetchUsecase _categoryFetchUsecase;
  CategoryCompnayFetchUsecase _categoryCompnayFetchUsecase;
  HomeCubit(
    this._productFetchUsecases,
    this._companyFetchUsecase,
    this._categoryFetchUsecase,
    this._categoryCompnayFetchUsecase,
  ) : super(HomeLoading());
  HomeAnalyticsDataModel? homeData;

  Future<void> fetchHomeAnalyticsData() async {
    emit(HomeLoading());
    if (kDebugMode) {
      // await Future.delayed(const Duration(seconds: 3));
    }
    final resp = await Future.wait([
      _productFetchUsecases.call(),
      _companyFetchUsecase.call(),
      _categoryFetchUsecase.call(),
      _categoryCompnayFetchUsecase.call(),
    ]);

    if (resp.any((a) => a is DataFailed)) {
      DataFailed? failState = resp.whereType<DataFailed>().firstOrNull;
      emit(HomeHasError(failState?.message ?? "Something wen't wrong"));
    } else {
      homeData = (resp[0].data as HomeAnalyticsDataModel?);
      homeData?.company = resp[1].data as List<CompanyModel>?;
      homeData?.category = resp[2].data as List<CategoryModel>?;
      homeData?.categoryCompnaymodel = resp[3].data as List<CategoryCompanyMdoel>?;
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
