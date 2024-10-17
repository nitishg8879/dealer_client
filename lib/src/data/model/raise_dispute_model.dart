import 'package:cloud_firestore/cloud_firestore.dart';

enum RaiseDisputeStatus {
  inProgress('In-progress'),
  approved('Approved'),
  fail('Fail');

  final String value;
  const RaiseDisputeStatus(this.value);

  // fromString method to convert string to enum value
  static RaiseDisputeStatus? fromString(String? status) {
    return RaiseDisputeStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => RaiseDisputeStatus.inProgress,
    );
  }
}

class RaiseDisputeModel {
  final String? id;
  final String? txnId;
  final String? orderId;
  final String? userId;
  final Timestamp? creationDate;
  final String? failReason;
  final RaiseDisputeStatus? status;

  const RaiseDisputeModel({
    this.txnId,
    this.orderId,
    this.userId,
    this.creationDate,
    this.failReason,
    this.status,
    this.id,
  });

  // fromJson factory method
  factory RaiseDisputeModel.fromJson(Map<String, dynamic> json) {
    return RaiseDisputeModel(
      txnId: json['txnId'] as String?,
      orderId: json['orderId'] as String?,
      userId: json['userId'] as String?,
      creationDate: json['creationDate'] != null ? json['creationDate'] as Timestamp : null,
      failReason: json['failReason'] as String?,
      status: json['status'] != null ? RaiseDisputeStatus.fromString(json['status'] as String?) : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'txnId': txnId,
      'orderId': orderId,
      'userId': userId,
      'creationDate': creationDate,
      'failReason': failReason,
      'status': status?.value,
    };
  }
}
