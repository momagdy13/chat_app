import 'package:chat_app/Constants/constants.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
    this.isSentByUser = false,
  });
  

  final String message;
  final bool isSentByUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7, // Responsive width
        ),
        decoration: BoxDecoration(
          color: isSentByUser ? const Color(0xff4E9F3D) : kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isSentByUser ? const Radius.circular(20) : Radius.zero,
            bottomRight: isSentByUser ? Radius.zero : const Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
