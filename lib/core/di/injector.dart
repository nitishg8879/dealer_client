import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/src/data/repo_impl/product_repo_impl.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product_fetch_usecases.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final appLocalService = AppLocalService();
  await appLocalService.init();
  getIt.registerSingleton(appLocalService);

  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());
  getIt.registerLazySingleton<ProductFetchUsecases>(() => ProductFetchUsecases(getIt()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));
}
