import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return true;
  }
}
