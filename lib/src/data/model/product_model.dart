import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  //? status
  bool? active;
  bool? sold;
  bool? bikeBooked;
  bool? bikeLocked;
  Timestamp? bikeLockedTill;
  //? category
  String? category;
  String? company;
  String? model;
  //?Details
  String? name;
  String? description;
  List<String>? images;
  num? enginecc;
  num? fine;
  num? kmDriven;
  num? owners;
  num? price;
  num? lastPrice;
  num? keys;
  Timestamp? bikeBuyDate;
  String? tyreCondition;
  String? numberPlate;
  Timestamp? insauranceValidity;
  Timestamp? bikeValidTill;
  //? Analytics
  Timestamp? creationDate;
  List<String>? searchQueryOnName;
  num? views;
  List<String>? favourites;
  //?Payment
  num? bookingAmount;
  List<ProductOrderModel>? userOrders;
  //?Chats
  List<String>? conversationIds;

  ProductModel({
    this.id,
    //? status
    this.active,
    this.sold,
    this.bikeBooked,
    this.bikeLocked,
    this.bikeLockedTill,
    //? category
    this.category,
    this.company,
    this.model,
    //?Details
    this.name,
    this.description,
    this.images,
    this.enginecc,
    this.fine,
    this.kmDriven,
    this.owners,
    this.price,
    this.lastPrice,
    this.keys,
    this.bikeBuyDate,
    this.tyreCondition,
    this.numberPlate,
    this.insauranceValidity,
    this.bikeValidTill,
    //? Analytics
    this.creationDate,
    this.searchQueryOnName,
    this.views,
    this.favourites,
    //? PAYEMNTS
    this.bookingAmount,
    this.userOrders,
    //? Chats
    this.conversationIds,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //? Status
    active = json['active'];
    sold = json['sold'];
    bikeBooked = json['bikeBooked'];
    bikeLocked = json['bikeLocked'] ?? false;
    bikeLockedTill = (json['bikeLockedTill'] as Timestamp?);
    //? category
    category = json['category'];
    company = json['company'];
    model = json['model'];
    //?Details
    name = json['name'];
    description = json['description'];
    images = (json['images'] as List<dynamic>?)?.cast<String>();
    enginecc = json['enginecc'];
    fine = json['fine'];
    kmDriven = json['kmDriven'];
    owners = json['owners'];
    price = json['price'];
    lastPrice = json['lastPrice'];
    keys = json['keys'];
    bikeBuyDate = json['bikeBuyDate'] as Timestamp?;
    tyreCondition = json['tyreCondition'];
    numberPlate = json['numberPlate'];
    insauranceValidity = json['insauranceValidity'] as Timestamp?;
    bikeValidTill = json['bikeValidTill'] as Timestamp?;
    //? Analytics
    creationDate = (json['creationDate'] as Timestamp?);
    searchQueryOnName = (json['searchQueryOnName'] as List<dynamic>?)?.cast<String>();
    views = json['views'];
    favourites = (json['favourites'] as List<dynamic>?)?.cast<String>();
    //?Payment
    bookingAmount = json['bookingAmount'];
    if (json['userOrders'] != null) {
      userOrders = [];
      for (var element in json['userOrders']) {
        userOrders?.add(ProductOrderModel.fromJson(element));
      }
    }
    //? Chats
    conversationIds = (json['conversationIds'] as List<dynamic>?)?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      //? Status
      'active': active,
      'sold': sold,
      'bikeBooked': bikeBooked,
      'bikeLocked': bikeLocked,
      'bikeLockedTill': bikeLockedTill, // Timestamp fields can be directly added
      //? Category
      'category': category,
      'company': company,
      'model': model,
      //? Details
      'name': name,
      'description': description,
      'images': images, // List of strings
      'enginecc': enginecc,
      'fine': fine,
      'kmDriven': kmDriven,
      'owners': owners,
      'price': price,
      'lastPrice': lastPrice,
      'keys': keys,
      'bikeBuyDate': bikeBuyDate, // Timestamp fields can be directly added
      'tyreCondition': tyreCondition,
      'numberPlate': numberPlate,
      'insauranceValidity': insauranceValidity, // Timestamp fields can be directly added
      'bikeValidTill': bikeValidTill, // Timestamp fields can be directly added
      //? Analytics
      'creationDate': creationDate, // Timestamp fields can be directly added
      'searchQueryOnName': searchQueryOnName, // List of strings
      'views': views,
      'favourites': favourites, // List of strings
      //? Payment
      'bookingAmount': bookingAmount,
      'userOrders': userOrders?.map((e) => e.toJson()).toList() ?? [],
      //? Chats
      'conversationId': conversationIds,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class ProductOrderModel {
  String? paymentId;
  String? orderId;
  String? txnId;
  String? userId;

  ProductOrderModel({this.paymentId, this.orderId, this.txnId, this.userId});

  ProductOrderModel.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    orderId = json['orderId'];
    txnId = json['txnId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentId'] = paymentId;
    data['orderId'] = orderId;
    data['txnId'] = txnId;
    data['userId'] = userId;
    return data;
  }
}

ProductModel dummyProduct = ProductModel(
  name: "Xpulse 200",
  price: 23232,
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
  kmDriven: 232323,
  model: "232323",
  bikeBuyDate: Timestamp.now(),
  insauranceValidity: Timestamp.now(),
  bikeValidTill: Timestamp.now(),
  numberPlate: "MH 04 3434",
  tyreCondition: "Good",
  fine: 300,
  owners: 2,
);
