part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Map<String, dynamic>> messages;

  ChatSuccess(this.messages);
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
