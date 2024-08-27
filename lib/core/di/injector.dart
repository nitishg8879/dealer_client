import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final appLocalService = getIt<AppLocalService>();
  await appLocalService.init();
}
