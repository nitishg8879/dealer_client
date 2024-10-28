import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum BookingStatus {
  Created(1),
  AutoRejected(2),
  RejectedByAdmin(3),
  CancelledByYou(4),
  RefundIntiated(5),
  RefundApproved(6),
  RefundRejected(7),
  Booked(8);

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
      case BookingStatus.RejectedByAdmin:
        return "Rejected By Admin";
      case BookingStatus.CancelledByYou:
        return "Cancelled By You";
      case BookingStatus.RefundIntiated:
        return "Refund Initiated";
      case BookingStatus.RefundApproved:
        return "Refund Approved";
      case BookingStatus.RefundRejected:
        return "Refund Rejected";
      case BookingStatus.Booked:
        return "Booked";
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.Created:
        return Colors.blue; // Blue for created
      case BookingStatus.AutoRejected:
        return Colors.orange; // Orange for auto rejected
      case BookingStatus.RejectedByAdmin:
        return Colors.red; // Red for rejected by admin
      case BookingStatus.CancelledByYou:
        return Colors.grey; // Grey for cancelled by user
      case BookingStatus.RefundIntiated:
        return Colors.purple; // Purple for refund initiated
      case BookingStatus.RefundApproved:
        return Colors.green; // Green for refund approved
      case BookingStatus.RefundRejected:
        return Colors.redAccent; // Red Accent for refund rejected
      case BookingStatus.Booked:
        return Colors.green; // Green for booked
    }
  }
}

class OrderTransactionModel {
  String txnId;
  String? refundtxnId;
  String paymentId;
  String userId;
  final List<String>? userName;
  Timestamp createdTime;
  Timestamp validTill;
  String productId;
  List<BookingStatus> status;
  String? rejectReason;
  String? id;

  OrderTransactionModel({
    required this.txnId,
    required this.paymentId,
    required this.userId,
    required this.createdTime,
    required this.validTill,
    required this.productId,
    required this.status,
    required this.userName,
    this.rejectReason,
    this.refundtxnId,
  });

  // Convert the OrderTransactionModel to a Map to store in Firestore
  Map<String, dynamic> toJson() {
    return {
      'txnId': txnId,
      'rejectReason': rejectReason,
      'paymentId': paymentId,
      'userId': userId,
      "userName": userName,
      'refundtxnId': refundtxnId,
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
      userName: (json['userName'] as List<dynamic>?)?.cast<String>(),
      paymentId: json['paymentId'],
      userId: json['userId'],
      refundtxnId: json['refundtxnId'],
      rejectReason: json['rejectReason'],
      createdTime: json['createdTime'] as Timestamp,
      validTill: json['validTill'] as Timestamp,
      productId: json['productId'],
      status: (json['status'] as List<dynamic>).map((value) => BookingStatus.fromValue(value)).toList(), // Convert integer to enum
    );
  }
}
