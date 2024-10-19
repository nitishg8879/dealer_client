import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductSellStatus {
  InReview(1),
  Approve(2),
  Reject(3);

  final int value;

  const ProductSellStatus(this.value);

  static ProductSellStatus fromValue(int value) {
    return ProductSellStatus.values.firstWhere((status) => status.value == value);
  }
}

class ProductSellModel {
  String? id;
  List<String>? images;
  String? name;
  List<String>? searchqueryonname;
  int? kmdrvien;
  double? price;
  int? owners;
  int? keys;
  Timestamp? buyDate;
  Timestamp? validTill;
  List<ProductSellStatus>? status;
  String? rejectReason;

  ProductSellModel({
    this.images,
    this.name,
    this.searchqueryonname,
    this.kmdrvien,
    this.price,
    this.owners,
    this.keys,
    this.buyDate,
    this.validTill,
    this.status,
    this.rejectReason,
  });

  // Manual fromJson method with null safety
  factory ProductSellModel.fromJson(Map<String, dynamic> json) {
    return ProductSellModel(
      images: (json['images'] as List?)?.map((item) => item as String).toList(),
      name: json['name'] as String?,
      searchqueryonname: (json['searchqueryonname'] as List?)?.map((item) => item as String).toList(),
      kmdrvien: json['kmdrvien'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      owners: json['owners'] as int?,
      keys: json['keys'] as int?,
      buyDate: json['buyDate'] as Timestamp?,
      validTill: json['validTill'] as Timestamp?,
      status: (json['status'] as List?)?.map((s) => ProductSellStatus.fromValue(s)).toList(),
      rejectReason: json['rejectReason'] as String?,
    );
  }

  // Manual toJson method with null safety
  Map<String, dynamic> toJson({bool isUpdate = false}) {
    return {
      'images': images,
      if (!isUpdate) 'creationDate': Timestamp.now(),
      'name': name,
      'searchqueryonname': searchqueryonname,
      'kmdrvien': kmdrvien,
      'price': price,
      'owners': owners,
      'keys': keys,
      'buyDate': buyDate,
      'validTill': validTill,
      'status': status?.map((s) => s.value).toList(), // Saving enum as list of int
      'rejectReason': rejectReason,
    };
  }
}
