import 'package:chat_app/Screens/home_page.dart';
import 'package:chat_app/cubits/button_state_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/registrer_cubit/register_cubit.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ButtonStateCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit()..getMessages(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Define routes with static route names from your screen widgets
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage()
        },
        initialRoute: LoginScreen.id,
        // Use the initial route based on your defined route names
      ),
    );
  }
}
