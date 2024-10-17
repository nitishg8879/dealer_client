import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingStatus {
  Created(1),
  AutoRejected(2),
  RejectedByAdmin(3),
  CancelledByYou(4),
  RefundIntiated(5),
  Booked(6);

  final int value;

  const BookingStatus(this.value);

  static BookingStatus fromValue(int value) {
    return BookingStatus.values.firstWhere((status) => status.value == value);
  }

  String get displayName {
    switch (this) {
      case BookingStatus.Created:
        return "Created";
      case BookingStatus.AutoRejected:
        return "Auto Rejected";
      case BookingStatus.RefundIntiated:
        return "Refunded Intiated";
      case BookingStatus.RejectedByAdmin:
        return "Rejected By Admin";
      case BookingStatus.CancelledByYou:
        return "Cancelled By You";
      case BookingStatus.Booked:
        return "Booked";
    }
  }
}

class OrderTransactionModel {
  String txnId;
  String userId;
  Timestamp createdTime;
  Timestamp validTill;
  String productId;
  List<BookingStatus> status;
  String? id;

  OrderTransactionModel({
    required this.txnId,
    required this.userId,
    required this.createdTime,
    required this.validTill,
    required this.productId,
    required this.status,
  });

  // Convert the OrderTransactionModel to a Map to store in Firestore
  Map<String, dynamic> toJson() {
    return {
      'txnId': txnId,
      'userId': userId,
      'createdTime': createdTime,
      'validTill': validTill,
      'productId': productId,
      'status': status.map((e) => e.value).toList(), // Store as integer
    };
  }

  // Create a OrderTransactionModel from a Firestore document
  factory OrderTransactionModel.fromJson(Map<String, dynamic> json) {
    return OrderTransactionModel(
      txnId: json['txnId'],
      userId: json['userId'],
      createdTime: json['createdTime'] as Timestamp,
      validTill: json['validTill'] as Timestamp,
      productId: json['productId'],
      status: (json['status'] as List<dynamic>).map((value) => BookingStatus.fromValue(value)).toList(), // Convert integer to enum
    );
  }
}
