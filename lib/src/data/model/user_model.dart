import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? email;
  String? profileUrl;
  String? phoneNumber;
  String? uuid;
  String? fullName;
  User? user;

  UserModel({
    required this.email,
    required this.profileUrl,
    required this.phoneNumber,
    required this.uuid,
    required this.fullName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    profileUrl = json['profileUrl'];
    phoneNumber = json['phoneNumber'];
    uuid = json['uuid'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['profileUrl'] = this.profileUrl;
    data['phoneNumber'] = this.phoneNumber;
    data['uuid'] = this.uuid;
    data['fullName'] = this.fullName;
    return data;
  }
}
