import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSource {
  Future<DataState<User?>> login() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user != null) {
        return DataSuccess(user.user!);
      } else {
        return const DataFailed(null, 400, "User cancel login process");
      }
    } on PlatformException catch (error) {
      return DataFailed(null, 500, error.message.toString());
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<bool> updateUserNameAndPhoneNumber({
    String? fullName,
    String? phoneNo,
  }) async {
    await getIt.get<AppFireBaseLoc>().users.doc(getIt.get<AppLocalService>().currentUser!.id).update(
      {'fullName': fullName, 'phoneNumber': phoneNo},
    ).catchError((error) {
      throw error;
    });
    return true;
  }

  Future<bool> logout() async {
    await Future.wait([
      FirebaseAuth.instance.signOut(),
      GoogleSignIn().signOut(),
      getIt<AppLocalService>().logout(),
    ]);
    return true;
  }
}
