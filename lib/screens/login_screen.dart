import 'package:chat_app/componets/custom_buttom.dart';
import 'package:chat_app/componets/custom_text_filed.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          // Background image
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display your logo
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                // App title
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                // Email TextField
                CustomTextFiled(
                  icon: Icons.email,
                  place_holder: 'Enter Your Email',
                ),
                const SizedBox(height: 20),

                // Password TextField

                CustomTextFiled(
                    icon: Icons.lock, place_holder: "Enter your password"),
                const SizedBox(height: 30),
                // Login Button
                CustomButtom(onPress: () {}, buttom_text: 'Login'),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 100, 181),
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
