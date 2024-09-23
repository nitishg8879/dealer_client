import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/data_sources/auth_data_source.dart';
import 'package:bike_client_dealer/src/data/model/user_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource);
  @override
  Future<DataState<UserModel?>> login() async {
    final state = await _authDataSource.login();
    if (state is DataSuccess) {
      state.data?.displayName;
      final newUser = UserModel(
        email: state.data?.email,
        profileUrl: state.data?.photoURL,
        phoneNumber: state.data?.phoneNumber,
        uuid: state.data?.uid,
        fullName: state.data?.displayName,
      );
      final resp = await getIt<AppFireBaseLoc>().users.where('email',isEqualTo: newUser.email).get();
      if(resp.docs.length == 1){
        //? Old User
      }else{
        //? New user
      }
      await getIt<AppLocalService>().login(newUser);
    } else {}
  }
}
