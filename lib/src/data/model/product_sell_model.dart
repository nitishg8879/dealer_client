import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum ProductSellStatus {
  InReview(1),
  Approve(2),
  Reject(3);

  final int value;

  const ProductSellStatus(this.value);

  static ProductSellStatus fromValue(int value) {
    return ProductSellStatus.values.firstWhere((status) => status.value == value);
  }

  // Getter for readable name
  String get readableName {
    switch (this) {
      case ProductSellStatus.InReview:
        return 'In Review';
      case ProductSellStatus.Approve:
        return 'Approved';
      case ProductSellStatus.Reject:
        return 'Rejected';
    }
  }

  // Getter for color
  Color get color {
    switch (this) {
      case ProductSellStatus.InReview:
        return AppColors.kOrange600; // or any color format like '#FFA500' for orange
      case ProductSellStatus.Approve:
        return AppColors.kGreen600; // or '#00FF00' for green
      case ProductSellStatus.Reject:
        return AppColors.kRed; // or '#FF0000' for red
    }
  }
}

class ProductSellModel {
  String? id;
  String? branchId;
  String? conversationId;
  List<String>? images;
  String? name;
  List<String>? searchqueryonname;
  int? kmdrvien;
  double? price;
  int? owners;
  int? keys;
  String? userId;
  Timestamp? buyDate;
  Timestamp? validTill;
  Timestamp? creationDate;
  ProductSellStatus? status;
  String? note;

  ProductSellModel({
    this.conversationId,
    this.images,
    this.branchId,
    this.userId,
    this.name,
    this.searchqueryonname,
    this.kmdrvien,
    this.price,
    this.owners,
    this.keys,
    this.buyDate,
    this.validTill,
    this.status,
    this.creationDate,
    this.note,
  });

  // Manual fromJson method with null safety
  factory ProductSellModel.fromJson(Map<String, dynamic> json) {
    return ProductSellModel(
      images: (json['images'] as List?)?.map((item) => item as String).toList(),
      name: json['name'] as String?,
      conversationId: json['conversationId'] as String?,
      userId: json['userId'] as String?,
      branchId: json['branchId'] as String?,
      searchqueryonname: (json['searchqueryonname'] as List?)?.map((item) => item as String).toList(),
      kmdrvien: json['kmdrvien'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      owners: json['owners'] as int?,
      keys: json['keys'] as int?,
      buyDate: json['buyDate'] as Timestamp?,
      creationDate: json['creationDate'] as Timestamp?,
      validTill: json['validTill'] as Timestamp?,
      status: json['status'] != null ? ProductSellStatus.fromValue(json['status']) : null,
      note: json['note'] as String?,
    );
  }

  // Manual toJson method with null safety
  Map<String, dynamic> toJson({bool isUpdate = false}) {
    return {
      'images': images,
      if (!isUpdate) 'creationDate': Timestamp.now(),
      'name': name,
      'conversationId': conversationId,
      'searchqueryonname': searchqueryonname,
      'kmdrvien': kmdrvien,
      'price': price,
      'owners': owners,
      'keys': keys,
      'userId': userId,
      'buyDate': buyDate,
      'validTill': validTill,
      'status': status?.value,
      'note': note,
    };
  }
}
