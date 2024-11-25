import 'package:chat_app/Components/chat_buble.dart';
import 'package:chat_app/Constants/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static String id = 'homePage';
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    // Scroll to the bottom function
    void _scrollToBottom() {
      if (_scrollController.hasClients) {
        // Wait for the scroll controller to attach
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image-removebg-preview.png',
              height: 50,
            ),
            const Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is ChatSuccess) {
            // Scroll to the bottom after fetching new messages
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatSuccess) {
            final messages = state.messages;
            return Column(
              children: [
                // Message List
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByUser = message['senderId'] == email;

                      return ChatBuble(
                        message: message['message'],
                        isSentByUser: isSentByUser,
                      );
                    },
                  ),
                ),
                // Message Input
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Color(0xff2B457E)),
                        onPressed: () {
                          final text = _messageController.text;
                          if (text.trim().isNotEmpty) {
                            BlocProvider.of<ChatCubit>(context).sendMessage(
                              message: text,
                              userId: email,
                            );

                            _messageController.clear();
                            _scrollToBottom(); // Scroll after sending the message
                          }
                        },
                      ),
                      hintText: 'Send Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Start a conversation.'));
        },
      ),
    );
  }
}
