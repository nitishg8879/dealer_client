import 'dart:convert';

import 'package:bike_client_dealer/src/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final _currentUserKey = "currentUserKey";
  UserModel? currentUser;
  bool isLoggedIn = false;

  Future<void> init() async {
    final encodedjsnData = await _secureStorage.read(key: _currentUserKey);
    if (encodedjsnData != null) {
      final decodedjson = await jsonDecode(encodedjsnData);
      currentUser = UserModel.fromJson(decodedjson);
      currentUser?.user = FirebaseAuth.instance.currentUser;
      isLoggedIn = true;
    }
  }

  Future<void> login(UserModel newUser) async {
    await _secureStorage.write(key: _currentUserKey, value: jsonEncode(newUser.toJson()));
    await init();
  }
}
