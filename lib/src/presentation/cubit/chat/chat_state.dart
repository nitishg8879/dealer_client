part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSending extends ChatState {
  final bool sending;
  ChatSending(this.sending);
}

final class ChatError extends ChatState {
  final String errorMsg;
  ChatError(this.errorMsg);
}

final class ChatLoaded extends ChatState {
  final List<Conversation> chats;
  ChatLoaded(this.chats);
}
