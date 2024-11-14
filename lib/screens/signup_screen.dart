import 'package:chat_app/componets/custom_buttom.dart';
import 'package:chat_app/componets/custom_text_filed.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  static String id = 'signUpScreen';
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Scrollable content
          Center(
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
                  // "Sign Up" header
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email TextField
                  CustomTextFiled(
                    onChange: (data) {
                      email = data;
                    },
                    icon: Icons.email,
                    place_holder: 'Enter Your Email',
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  CustomTextFiled(
                    onChange: (data) {
                      password = data;
                    },
                    icon: Icons.lock,
                    place_holder: "Enter your password",
                  ),
                  const SizedBox(height: 30),
                  // Register Button
                  CustomButtom(
                    onPress: () async {
                      // try {
                      //   var auth = FirebaseAuth.instance;
                      //   UserCredential user =
                      //       await auth.createUserWithEmailAndPassword(
                      //           email: email!, password: password!);
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                    buttom_text: 'Register',
                  ),
                  const SizedBox(height: 20),
                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 100, 181),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
