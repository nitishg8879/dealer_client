import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/user_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/auth_repo.dart';

class LoginUsecase {
  final AuthRepo _authRepo;

  LoginUsecase(this._authRepo);

  Future<DataState<UserModel?>> call() {
    return _authRepo.login();
  }
}
