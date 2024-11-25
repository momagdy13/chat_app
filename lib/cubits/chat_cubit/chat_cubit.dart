import 'package:bloc/bloc.dart';
import 'package:chat_app/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  /// Sends a message to Firestore
  void sendMessage({required String message, required String userId}) async {
    if (message.trim().isEmpty) return;
    try {
      await messages.add({
        'message': message,
        'senderId':userId,
        'timestamp':  FieldValue.serverTimestamp(),
      });
      // No need to emit a state here as `getMessages` listens to updates
    } catch (e) {
      emit(ChatError('Error sending message: $e'));
    }
  }

  /// Listens to Firestore snapshots and emits messages
  void getMessages() {
    emit(ChatLoading());
    messages.orderBy('timestamp', descending: true).snapshots().listen(
      (snapshot) {
        final List<Map<String, dynamic>> chatMessages =
            snapshot.docs.map((doc) {
          return {
            'message': doc['message'],
            'senderId': doc['senderId'],
            'timestamp': doc['timestamp'],
          };
        }).toList();
        emit(ChatSuccess(chatMessages));
      },
      onError: (error) {
        emit(ChatError('Error fetching messages: $error'));
      },
    );
  }
}
