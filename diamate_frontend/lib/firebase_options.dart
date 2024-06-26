// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB-CNbq-CGekjt6hyNLZlwL8dWmhyrd9vE',
    appId: '1:317088921173:web:a655b4eaf9e2efa4a2c6dc',
    messagingSenderId: '317088921173',
    projectId: 'diamate-ff8c0',
    authDomain: 'diamate-ff8c0.firebaseapp.com',
    storageBucket: 'diamate-ff8c0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOzs-uP4IvVHAqKmyhlNBiW2TE4vSLYPY',
    appId: '1:317088921173:android:1e5cd285398e99c0a2c6dc',
    messagingSenderId: '317088921173',
    projectId: 'diamate-ff8c0',
    storageBucket: 'diamate-ff8c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAmEinhw0bG_-fJHu_tsLKgmJiYy_9f3U',
    appId: '1:317088921173:ios:7746ec10e96daca1a2c6dc',
    messagingSenderId: '317088921173',
    projectId: 'diamate-ff8c0',
    storageBucket: 'diamate-ff8c0.appspot.com',
    iosBundleId: 'com.example.diamateFrontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAmEinhw0bG_-fJHu_tsLKgmJiYy_9f3U',
    appId: '1:317088921173:ios:3d35c4efee98269aa2c6dc',
    messagingSenderId: '317088921173',
    projectId: 'diamate-ff8c0',
    storageBucket: 'diamate-ff8c0.appspot.com',
    iosBundleId: 'com.example.diamateFrontend.RunnerTests',
  );
}
