import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/data_sources/auth_data_source.dart';
import 'package:bike_client_dealer/src/data/data_sources/product_data_source.dart';
import 'package:bike_client_dealer/src/data/data_sources/transaction_data_source.dart';
import 'package:bike_client_dealer/src/data/repo_impl/auth_repo_impl.dart';
import 'package:bike_client_dealer/src/data/repo_impl/product_repo_impl.dart';
import 'package:bike_client_dealer/src/data/repo_impl/transaction_repo_impl.dart';
import 'package:bike_client_dealer/src/domain/repositories/auth_repo.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';
import 'package:bike_client_dealer/src/domain/repositories/transaction_repo.dart';
import 'package:bike_client_dealer/src/domain/use_cases/auth/login_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/auth/logout_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/categories/category_compnay_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/categories/category_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/categories/company_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fav_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fetch_product_by_id_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/home_analytics_fetch_usecases.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/product_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/product_total_count_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/transaction_usecase.dart';
import 'package:bike_client_dealer/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
   await dotenv.load(fileName: ".env");
  //? Needed
  final appLocalService = AppLocalService();
  await appLocalService.init();
  getIt.registerSingleton(appLocalService);
  getIt.registerSingleton(AppFireBaseLoc());

  //? Auth
  getIt.registerLazySingleton(() => AuthDataSource());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt.get()));
  getIt.registerLazySingleton(() => LoginUsecase(getIt.get()));
  getIt.registerLazySingleton(() => LogoutUsecase(getIt.get()));
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt.get(), getIt.get()));

  //? Products
  getIt.registerLazySingleton(() => ProductDataSource());
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(getIt.get()));
  getIt.registerLazySingleton<AddToFavouriteUseCase>(() => AddToFavouriteUseCase(getIt.get()));
  getIt.registerLazySingleton<RemoveFromFavouriteUsecase>(() => RemoveFromFavouriteUsecase(getIt.get()));

  getIt.registerLazySingleton(() => ProductFetchUsecase(getIt.get()));
  getIt.registerLazySingleton(() => HomeAnalyticsFetchUsecases(getIt.get()));
  getIt.registerLazySingleton(() => CompanyFetchUsecase(getIt.get()));
  getIt.registerLazySingleton(() => CategoryFetchUsecase(getIt.get()));
  getIt.registerLazySingleton(() => CategoryCompnayFetchUsecase(getIt.get()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt.get(), getIt.get(), getIt.get(), getIt.get(), getIt.get()));

  getIt.registerLazySingleton(() => FetchProductByIdUsecase(getIt.get()));
  getIt.registerLazySingleton(() => FetchFavouriteProductsUseCase(getIt.get()));
  getIt.registerLazySingleton(() => ProductTotalCountUsecase(getIt.get()));

  //? Transaction
  getIt.registerLazySingleton(() => TransactionDataSource());
  getIt.registerLazySingleton<TransactionRepo>(() => TransactionRepoImpl(getIt.get()));
  getIt.registerLazySingleton(() => TransactionFetchUseCase(getIt.get()));
  getIt.registerLazySingleton(() => TransactionCreateUseCase(getIt.get()));
}
