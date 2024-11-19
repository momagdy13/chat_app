// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBC_iGfzjD2Z3Bgar9N7PdEt-BVJR9GTY',
    appId: '1:82676971750:web:a6b907fa1efe13b1d02327',
    messagingSenderId: '82676971750',
    projectId: 'chat-app-a98a8',
    authDomain: 'chat-app-a98a8.firebaseapp.com',
    storageBucket: 'chat-app-a98a8.firebasestorage.app',
    measurementId: 'G-BR9DBPWQD6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdMC5qEVJTMjcG-ucAVV74Rbs-JNrOqTY',
    appId: '1:82676971750:android:041bf2561b5f277dd02327',
    messagingSenderId: '82676971750',
    projectId: 'chat-app-a98a8',
    storageBucket: 'chat-app-a98a8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEqmFxDuP1rlVCQZAEGs3XKqvV50L-iFk',
    appId: '1:82676971750:ios:3b1e798692b62c48d02327',
    messagingSenderId: '82676971750',
    projectId: 'chat-app-a98a8',
    storageBucket: 'chat-app-a98a8.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEqmFxDuP1rlVCQZAEGs3XKqvV50L-iFk',
    appId: '1:82676971750:ios:3b1e798692b62c48d02327',
    messagingSenderId: '82676971750',
    projectId: 'chat-app-a98a8',
    storageBucket: 'chat-app-a98a8.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCBC_iGfzjD2Z3Bgar9N7PdEt-BVJR9GTY',
    appId: '1:82676971750:web:58deee1055e0e9ffd02327',
    messagingSenderId: '82676971750',
    projectId: 'chat-app-a98a8',
    authDomain: 'chat-app-a98a8.firebaseapp.com',
    storageBucket: 'chat-app-a98a8.firebasestorage.app',
    measurementId: 'G-HYTWVVX6Z9',
  );
}