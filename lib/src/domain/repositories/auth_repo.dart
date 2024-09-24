import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/user_model.dart';

abstract class AuthRepo {
  Future<DataState<UserModel?>> login();
  Future<bool> logout();
}
