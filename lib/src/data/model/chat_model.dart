import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  String? user;
  int? unreadChatCount;
  String? profileUrl;
  String? name;
  List<String>? nameQuery;
  String? managerId;
  Timestamp? lastMessageTime;
  String? lastMessage;

  ChatModel({
    required this.user,
    this.unreadChatCount,
    required this.profileUrl,
    required this.name,
    this.managerId,
    this.lastMessageTime,
    required this.nameQuery,
    this.lastMessage,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    unreadChatCount = json['unreadChatCount'];
    profileUrl = json['profileUrl'];
    name = json['name'];
    managerId = json['managerId'];
    nameQuery = (json['nameQuery'] as List<dynamic>?)?.cast<String>();
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'] as Timestamp?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['unreadChatCount'] = unreadChatCount;
    data['profileUrl'] = profileUrl;
    data['nameQuery'] = nameQuery;
    data['lastMessage'] = lastMessage;
    data['name'] = name;
    data['managerId'] = managerId;
    data['lastMessageTime'] = lastMessageTime;
    return data;
  }
}

class Conversation {
  String? productID;
  String? message;
  bool isUser = true;
  Timestamp? time;
  String? id;
  List<String>? documensts;

  Conversation({
    required this.message,
    this.productID,
    this.documensts,
  })  : time = Timestamp.now();

  Conversation.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    message = json['message'];
    time = json['time'] as Timestamp?;
    isUser = json['isUser'];
    documensts = (json['documensts'] as List<dynamic>?)?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['productID'] = productID;
    data['time'] = time;
    data['isUser'] = isUser;
    data['documensts'] = documensts;
    return data;
  }
}
