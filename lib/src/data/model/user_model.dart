import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String? email;
  String? profileUrl;
  String? phoneNumber;
  String? uuid;
  String? fullName;
  User? user;
  bool? active;
  Timestamp? creationDate;
  String? suspendReason;

  UserModel({
    required this.email,
    required this.profileUrl,
    required this.phoneNumber,
    required this.uuid,
    required this.fullName,
    required this.creationDate,
    this.active = true,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    profileUrl = json['profileUrl'];
    phoneNumber = json['phoneNumber'];
    uuid = json['uuid'];
    fullName = json['fullName'];
    creationDate = json['creationDate'];
    active = json['active'];
    suspendReason = json['suspendReason'];
    id = json['id'];
  }

  Map<String, dynamic> toJson({bool fromSave = true}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['profileUrl'] = profileUrl;
    data['phoneNumber'] = phoneNumber;
    data['uuid'] = uuid;
    data['fullName'] = fullName;
    data['active'] = active;
    data['suspendReason'] = suspendReason;
    if (fromSave) {
      data['creationDate'] = creationDate;
    } else {
      data['creationDate'] = creationDate?.toDate().ddMMYYYYHHMMSS;
      data['id'] = id;
    }
    return data;
  }
}