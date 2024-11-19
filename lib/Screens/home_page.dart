import 'package:chat_app/Components/chat_buble.dart';
import 'package:chat_app/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static String id = 'homePage';
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    Future<void> sendMessage(String message) async {
      if (message.trim().isEmpty) return;
      try {
        await messages.add({
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
          'senderId': email,
        });
        _messageController.clear();
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } catch (e) {
        print('Error sending message: $e');
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
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  messages.orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                final messageDocs = snapshot.data!.docs;
                print(email);
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messageDocs.length,
                  itemBuilder: (context, index) {
                    final messageData = messageDocs[index];
                    final messageText = messageData['message'] ?? 'No message';

                    final senderId = messageData['senderId'] ?? 'unknown';
                    final isSentByUser = senderId == email;

                    return ChatBuble(
                      message: messageText,
                      isSentByUser: isSentByUser,
                    );
                  },
                );
              },
            ),
          ),
          // Input Field
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _messageController,
              onSubmitted: (value) => sendMessage(value),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Color(0xff2B457E)),
                  onPressed: () => sendMessage(_messageController.text),
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
      ),
    );
  }
}
