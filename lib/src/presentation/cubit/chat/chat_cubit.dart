import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/data_sources/chat_data_source.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/data/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/file_picker_result.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading());

  ChatModel? chatModel;
  int myMessageCount = 0;
  String? get chatId => getIt.get<AppLocalService>().currentUser?.chatId;
  String? get conversationId => getIt.get<AppLocalService>().currentUser?.conversationId;

  Future<void> fetchChats({bool callLoading = true}) async {
    try {
      if (callLoading) {
        emit(ChatLoading());
      }
      UserModel? currentUser = getIt.get<AppLocalService>().currentUser;
      await intializeUserChat(currentUser);
      currentUser = getIt.get<AppLocalService>().currentUser;

      final tempChat = await getIt.get<AppFireBaseLoc>().chats.doc(chatId).get();
      chatModel = ChatModel.fromJson(tempChat.data() ?? {})..id = tempChat.id;
      if (chatModel?.unreadChatCount != null && chatModel?.unreadChatCount == 0) {
        myMessageCount = 0;
      }
      final chatResp = await getIt.get<AppFireBaseLoc>().conversation.doc(conversationId).get();
      final dynamicChats = chatResp.data()?['conversation'] as List<dynamic>;
      emit(ChatLoaded(dynamicChats.map((e) => Conversation.fromJson(e)).toList().reversed.toList()));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> intializeUserChat(UserModel? currentUser) async {
    if (currentUser == null) {
      throw Exception("User not logged in.");
    }
    if (currentUser.chatId == null) {
      final tempchatModel = ChatModel(
        user: currentUser.id,
        profileUrl: currentUser.profileUrl,
        name: currentUser.fullName,
        nameQuery: HelperFun.setSearchParameters(currentUser.fullName!),
      );
      final resp = await getIt.get<AppFireBaseLoc>().chats.add(tempchatModel.toJson());
      currentUser.chatId = resp.id;
      currentUser.conversationId = resp.id;
      await getIt.get<AppLocalService>().login(currentUser);
      await getIt.get<AppFireBaseLoc>().conversation.doc(resp.id).set({"conversation": []});
      getIt.get<AppFireBaseLoc>().users.doc(getIt.get<AppLocalService>().currentUser!.id).update({
        'chatId': resp.id,
        'conversationId': resp.id,
      });
    }
  }

  Future<void> sendMessage(TextEditingController messageCtr, FilePickerResult? filePickerResult, ProductModel? pinProduct) async {
    if (state is ChatSending && (state as ChatSending).sending) return;
    emit(ChatSending(true));
    myMessageCount = myMessageCount + 1;
    getIt.get<AppFireBaseLoc>().chats.doc(chatId).update({
      'lastMessageTime': Timestamp.now(),
      'unreadChatCount': myMessageCount,
      'lastMessage': messageCtr.text.trim(),
    });
    var networkDoc = <String>[];
    if (filePickerResult?.files.isNotEmpty ?? false) {
      for (PlatformFile element in filePickerResult?.files ?? []) {
        final downloadUrl = await HelperFun.uploadFile(getIt.get<AppFireBaseLoc>().chatStorage.child(element.name), element, (val) {});
        if (downloadUrl != null) {
          networkDoc.add(downloadUrl);
        }
      }
    }
    final newConversation = Conversation(
      message: messageCtr.text.trim(),
      productID: pinProduct?.id,
      documensts: networkDoc,
    );
    await getIt.get<AppFireBaseLoc>().conversation.doc(conversationId).update({
      'conversation': FieldValue.arrayUnion([newConversation.toJson()])
    });
    messageCtr.clear();
    emit(ChatSending(false));
    fetchChats(callLoading: false);
  }

  void refreshChatStreamly() {}
}
