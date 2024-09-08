import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionsModel {
  TransactionsType? transactionsType;
  String? transactionID;
  DateTime? txnDateTime;
  num? amount;
  String? label;
  String? description;
  TransactionsModel({
    this.transactionsType,
    this.transactionID,
    this.txnDateTime,
    this.amount,
    this.label,
    this.description,
  });
}

enum TransactionsType {
  credit,
  debit,
  pending,
  failed;

  Color get color {
    return switch (this) {
      credit => AppColors.kGreen600,
      debit => AppColors.kYellow300,
      pending => AppColors.kOrange500,
      failed => AppColors.kRed,
    };
  }
}
