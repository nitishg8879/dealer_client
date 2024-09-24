import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/data_sources/auth_data_source.dart';
import 'package:bike_client_dealer/src/data/model/user_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource);
  @override
  Future<DataState<UserModel?>> login() async {
    final state = await _authDataSource.login();
    if (state is DataSuccess) {
      state.data?.displayName;
      UserModel user = UserModel(
        email: state.data?.email,
        profileUrl: state.data?.photoURL,
        phoneNumber: state.data?.phoneNumber,
        uuid: state.data?.uid,
        fullName: state.data?.displayName,
        creationDate: Timestamp.now(),
      );
      final resp = await getIt<AppFireBaseLoc>().users.where('email', isEqualTo: user.email).get();
      if (resp.docs.length == 1) {
        //? Old User
        user = UserModel.fromJson(resp.docs.first.data());
      } else {
        //? New user
        final createdUser = await getIt<AppFireBaseLoc>().users.add(user.toJson());
        user.id = createdUser.id;
      }
      await getIt<AppLocalService>().login(user);
      return DataSuccess(user);
    } else {
      return DataFailed(null, 2, state.message);
    }
  }

  @override
  Future<bool> logout() {
    return _authDataSource.logout();
  }
}
