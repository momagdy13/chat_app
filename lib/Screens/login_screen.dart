import 'package:chat_app/Components/custom_buttom.dart';
import 'package:chat_app/Components/custom_text_field.dart';
import 'package:chat_app/Components/show_snackbar.dart';
import 'package:chat_app/Screens/home_page.dart';
import 'package:chat_app/Screens/signup_screen.dart';
import 'package:chat_app/cubits/button_state_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ButtonStateCubit()),
          BlocProvider(create: (_) => LoginCubit()),
        ],
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
              if (state is LoginLoading) {
                isLoading = true;
              } else if (state is LoginSuccess) {
                isLoading = false;
                Navigator.pushNamed(context, HomePage.id, arguments: email);
              } else if (state is LoginFailure) {
                isLoading = false;
                showSnackBar(
                    context, state.errorMessage); // Show specific error
              }
            }, builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: isLoading,
                child: Scaffold(
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
                                const Text(
                                  'Scholar Chat',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
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
                                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  onChange: (data) {
                                    email = data;
                                    context
                                        .read<ButtonStateCubit>()
                                        .updateButtonState(email, password);
                                  },
                                ),
                                const SizedBox(height: 9),
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
                                    context
                                        .read<ButtonStateCubit>()
                                        .updateButtonState(email, password);
                                  },
                                ),
                                const SizedBox(height: 30),
                                // Register Button with Bloc for enabling/disabling
                                BlocBuilder<ButtonStateCubit, bool>(
                                  builder: (context, isButtonEnabled) {
                                    return CustomButtom(
                                        onPress: () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            BlocProvider.of<LoginCubit>(context)
                                                .loginUser(
                                                    email: email!,
                                                    password: password!);
                                          }
                                        },
                                        buttomText: 'Login',
                                        isEnabled: isButtonEnabled);
                                  },
                                ),
                                const SizedBox(height: 20),
                                // Sign-up link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 18),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, SignupScreen.id);
                                      },
                                      child: const Text(
                                        "Sign up",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 100, 181),
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
                ),
              );
            });
          },
        ));
  }
}
