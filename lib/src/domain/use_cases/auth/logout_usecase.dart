import 'package:bike_client_dealer/src/domain/repositories/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo _authRepo;

  LogoutUsecase(this._authRepo);

  Future<bool> call() {
    return _authRepo.logout();
  }
}
