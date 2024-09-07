import 'package:bike_client_dealer/core/util/app_enums.dart';

class ChatModel {
  final String message;
  final chatsRowType chatType;
  final bool isSender;
  final DateTime dateTime;
  final String? image;
  ChatModel({
    required this.message,
    required this.isSender,
    required this.dateTime,
    this.chatType = chatsRowType.normalText,
    this.image,
  });
}

List<ChatModel> dummyMessage = [
  // ChatModel(
  //   message: "Hey",
  //   isSender: true,
  //   dateTime: DateTime.now(),
  // ),
  // ChatModel(
  //   message: "Hello",
  //   isSender: false,
  //   dateTime: DateTime.now().add(const Duration(seconds: 2)),
  // ),
  // ChatModel(
  //   message: "What is the Price of x pulse 200",
  //   isSender: true,
  //   dateTime: DateTime.now().add(const Duration(seconds: 4)),
  // ),
  // ChatModel(
  //   message: "it's around something 75k",
  //   isSender: false,
  //   dateTime: DateTime.now().add(const Duration(seconds: 7)),
  // ),
];
