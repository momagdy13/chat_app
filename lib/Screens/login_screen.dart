import 'package:chat_app/Components/custom_buttom.dart';
import 'package:chat_app/Components/custom_text_field.dart';
import 'package:chat_app/Screens/home_page.dart';
import 'package:chat_app/Screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool _isLoading = false;
  bool _isButtonEnabled = false; // Button state

  // Method to update button state
  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = email != null &&
          email!.isNotEmpty &&
          password != null &&
          password!.length >= 6;
    });
  }

  // Register User Method
  Future<void> loginUser() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      showSnackBar(context, "Login Successful");
      _formKey.currentState?.reset(); // Clear the form fields
      setState(() {
        showSnackBar(context, "Login Successful");
        Navigator.pushNamed(context, HomePage.id, arguments: email);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackBar(context, 'Invalid Email');
      } else if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else {
        showSnackBar(context, e.message ?? 'An error occurred');
      }
    } catch (e) {
      showSnackBar(context, '$e');
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Show SnackBar Method
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/pexels-artempodrez-7233099.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Scrollable content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Email TextField
                    CustomTextField(
                      icon: Icons.email,
                      placeHolder: 'Enter Your Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChange: (data) {
                        email = data;
                        _updateButtonState();
                      },
                    ),
                    const SizedBox(height: 5),
                    // Password TextField
                    CustomTextField(
                      icon: Icons.lock,
                      placeHolder: 'Enter your password',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onChange: (data) {
                        password = data;
                        _updateButtonState();
                      },
                    ),
                    const SizedBox(height: 30),
                    // Register Button with Loading Indicator
                    _isLoading
                        ? const CircularProgressIndicator()
                        : CustomButtom(
                            onPress: () async {
                              // Close the keyboard
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState?.validate() ?? false) {
                                await loginUser();
                              }
                            },
                            buttomText: 'Login',
                            isEnabled: _isButtonEnabled,
                          ),
                    const SizedBox(height: 20),
                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignupScreen.id);
                          },
                          child: const Text(
                            "Sign up",
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
          ),
        ],
      ),
    );
  }
}
