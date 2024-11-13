import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled({required this.icon, required this.place_holder});

  IconData? icon;
  String? place_holder;
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: '$place_holder',
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
