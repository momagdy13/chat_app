import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback onPress;
  final String buttomText;
  final bool isEnabled;

  const CustomButtom({
    super.key,
    required this.onPress,
    required this.buttomText,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Disable button if isEnabled is false
      
      onPressed: isEnabled ? onPress : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? Colors.black
            : const Color.fromARGB(
                255, 70, 70, 70), // Optional: Change color if disabled
        padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttomText,
        style: const TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }
}
