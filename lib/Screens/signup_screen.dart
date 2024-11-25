import 'package:chat_app/Components/custom_buttom.dart';
import 'package:chat_app/Components/custom_text_field.dart';
import 'package:chat_app/Components/show_snackbar.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/cubits/button_state_cubit.dart';
import 'package:chat_app/cubits/registrer_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'signUpScreen';
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ButtonStateCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
      ],
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            _isLoading = true;
          } else if (state is RegisterSuccess) {
            Navigator.pushNamed(context, LoginScreen.id);
            _isLoading = false;
          } else if (state is RegisterFailure) {
            showSnackBar(context, state.errorMessage);
            _isLoading = false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: Scaffold(
              body: Stack(
                children: [
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
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        BlocProvider.of<RegisterCubit>(context)
                                            .registerUser(
                                                email: email!,
                                                password: password!);
                                      }
                                    },
                                    buttomText: 'Register',
                                    isEnabled: isButtonEnabled);
                              },
                            ),
                            const SizedBox(height: 20),
                            // Login link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 18),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
