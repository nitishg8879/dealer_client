import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/data_sources/chat_data_source.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/data/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading());

  ChatModel? chatModel;

  Future<void> fetchChats({bool callLoading = true}) async {
    try {
      if (callLoading) {
        emit(ChatLoading());
      }
      final currentUser = getIt.get<AppLocalService>().currentUser;
      await intializeUserChat(currentUser);
      if (chatModel == null) {
        getIt.get<AppFireBaseLoc>().chats.doc(currentUser?.chatId).get().then((val) {
          if (val.data() != null) {
            chatModel = ChatModel.fromJson(val.data()!);
            chatModel?.id = val.id;
          }
        });
      }
      final chatResp = await getIt.get<AppFireBaseLoc>().conversation.doc(currentUser?.conversationId).get();
      final dynamicChats = chatResp.data()?['conversation'] as List<dynamic>;
      emit(ChatLoaded(dynamicChats.map((e) => Conversation.fromJson(e)).toList()));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> intializeUserChat(UserModel? currentUser) async {
    if (currentUser == null) {
      throw Exception("User not logged in.");
    }
    if (currentUser.chatId == null) {
      final chatModel = ChatModel(
        user: currentUser.id,
        profileUrl: currentUser.profileUrl,
        name: currentUser.fullName,
        nameQuery: HelperFun.setSearchParameters(currentUser.fullName!),
      );
      final resp = await getIt.get<AppFireBaseLoc>().chats.add(chatModel.toJson());
      currentUser.chatId = resp.id;
      currentUser.conversationId = resp.id;
      getIt.get<AppLocalService>().login(currentUser);
      await getIt.get<AppFireBaseLoc>().conversation.doc(resp.id).update({"conversation": []});
    }
  }

  void sendMessage() {}

  void refreshChatStreamly() {}
}
