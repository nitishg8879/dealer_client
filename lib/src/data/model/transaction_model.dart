import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionsModel {
  TransactionsModel({
    required this.transactionsType,
    required this.transactionId,
    required this.amount,
    required this.label,
    required this.failedReason,
    required this.txnDateTime,
    required this.userId,
    required this.productId,
    this.id,
  });

  final TransactionsType? transactionsType;
  final String? transactionId;
  final num? amount;
  final String? label;
  final String? failedReason;
  final Timestamp? txnDateTime;
  final String? userId;
  final String? productId;
  final String? id;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      transactionsType: TransactionsType.fromString(json["transactionsType"]),
      transactionId: json["transactionID"],
      amount: json["amount"],
      label: json["label"],
      failedReason: json["failedReason"],
      txnDateTime: json["txnDateTime"] as Timestamp?,
      userId: json["userId"],
      productId: json["productId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "transactionsType": transactionsType?.name,
        "transactionID": transactionId,
        "amount": amount,
        "label": label,
        "failedReason": failedReason,
        "txnDateTime": txnDateTime,
        "userId": userId,
        "productId": productId,
      };
}

enum TransactionsType {
  success,
  fail,
  refund;

  // Color getter
  Color get color {
    return switch (this) {
      success => AppColors.kGreen600,
      fail => AppColors.kRed,
      refund => AppColors.kOrange400,
    };
  }

  // fromString method
  static TransactionsType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'success':
        return TransactionsType.success;
      case 'fail':
        return TransactionsType.fail;
      case 'refund':
        return TransactionsType.refund;
      default:
        throw ArgumentError('Unknown TransactionsType: $type');
    }
  }

  // Readable string getter
  String get readable {
    return switch (this) {
      success => 'Success',
      fail => 'Fail',
      refund => 'Refund',
    };
  }
}
