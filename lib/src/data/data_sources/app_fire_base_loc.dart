import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppFireBaseLoc {
  String? get razorKey => dotenv.env['razorKey'];
  String? get razorValue => dotenv.env['razorValue'];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => FirebaseAuth.instance.currentUser;

  //? Tables
  final String categoriesTableName = "categories";
  final String companiesTableName = "companies";
  final String modelsTableName = "models";
  final String productBuyTableName = "productBuy";
  final String productTableName = "products";
  final String transactionTableName = "transactions";
  final String chatTableName = "chats";
  final String conversationTableName = "conversation";
  final String usersAdminTableName = "usersAdmin";
  final String usersTableName = "users";
  final String homeDataTableTableName = "homeData";
  final String ordersTableName = "orders";
  // final String raiseDisputeTableName = "raiseDispute";
  CollectionReference<Map<String, dynamic>> get categories => _firestore.collection(categoriesTableName);
  CollectionReference<Map<String, dynamic>> get company => _firestore.collection(companiesTableName);
  CollectionReference<Map<String, dynamic>> get model => _firestore.collection(modelsTableName);
  CollectionReference<Map<String, dynamic>> get product => _firestore.collection(productTableName);
  CollectionReference<Map<String, dynamic>> get transactions => _firestore.collection(transactionTableName);
  CollectionReference<Map<String, dynamic>> get chats => _firestore.collection(chatTableName);
  CollectionReference<Map<String, dynamic>> get conversation => _firestore.collection(conversationTableName);
  CollectionReference<Map<String, dynamic>> get productBuy => _firestore.collection(productBuyTableName);
  CollectionReference<Map<String, dynamic>> get usersAdmin => _firestore.collection(usersAdminTableName);
  CollectionReference<Map<String, dynamic>> get users => _firestore.collection(usersTableName);
  CollectionReference<Map<String, dynamic>> get homeData => _firestore.collection(homeDataTableTableName);
  CollectionReference<Map<String, dynamic>> get order => _firestore.collection(ordersTableName);
  // CollectionReference<Map<String, dynamic>> get raiseDispute => _firestore.collection(raiseDisputeTableName);

  //? Storage Bucket
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final String sellBucket = "sell/";
  Reference get sellStorage => _firebaseStorage.ref().child(sellBucket);
}
