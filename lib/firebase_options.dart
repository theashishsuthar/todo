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
    apiKey: 'AIzaSyA46tTcpWKnFqoeUm8tTNRk1EkCiVUz9GM',
    appId: '1:781994699034:web:e2bf9a043ba33b753ba4a3',
    messagingSenderId: '781994699034',
    projectId: 'todo-sample-693c8',
    authDomain: 'todo-sample-693c8.firebaseapp.com',
    storageBucket: 'todo-sample-693c8.appspot.com',
    measurementId: 'G-ZMD515FEML',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzzgcJbJXCbifLRlQgVvWnN3yi4nyo6Qw',
    appId: '1:781994699034:android:f4e7c2a0ee48bd4f3ba4a3',
    messagingSenderId: '781994699034',
    projectId: 'todo-sample-693c8',
    storageBucket: 'todo-sample-693c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcDKNPVCxGAXRi_g8bNlb220wDJ3ud1L4',
    appId: '1:781994699034:ios:112e5ce2d128ec183ba4a3',
    messagingSenderId: '781994699034',
    projectId: 'todo-sample-693c8',
    storageBucket: 'todo-sample-693c8.appspot.com',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcDKNPVCxGAXRi_g8bNlb220wDJ3ud1L4',
    appId: '1:781994699034:ios:112e5ce2d128ec183ba4a3',
    messagingSenderId: '781994699034',
    projectId: 'todo-sample-693c8',
    storageBucket: 'todo-sample-693c8.appspot.com',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA46tTcpWKnFqoeUm8tTNRk1EkCiVUz9GM',
    appId: '1:781994699034:web:6e4dcd9540bc53a53ba4a3',
    messagingSenderId: '781994699034',
    projectId: 'todo-sample-693c8',
    authDomain: 'todo-sample-693c8.firebaseapp.com',
    storageBucket: 'todo-sample-693c8.appspot.com',
    measurementId: 'G-10HLS0T0ZL',
  );
}
