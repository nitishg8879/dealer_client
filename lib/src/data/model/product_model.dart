import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  //? status
  bool? active;
  bool? sold;
  bool? bikeBooked;
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
  List<String>? transactionID;
  List<String>? user;
  //?Chats
  String? conversationId;

  ProductModel({
    this.id,
    //? status
    this.active,
    this.sold,
    this.bikeBooked,
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
    this.transactionID,
    this.bookingAmount,
    this.user,
    //? Chats
    this.conversationId,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //? Status
    active = json['active'];
    sold = json['sold'];
    bikeBooked = json['bikeBooked'];
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
    transactionID = (json['transactionID'] as List<dynamic>?)?.cast<String>();
    user = (json['user'] as List<dynamic>?)?.cast<String>();
    //? Chats
    conversationId = json['conversationId'];
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      //? Status
      'active': active,
      'sold': sold,
      'bikeBooked': bikeBooked,
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
      'transactionID': transactionID,
      'user': user,
      //? Chats
      'conversationId': conversationId,
    };
  }
}
