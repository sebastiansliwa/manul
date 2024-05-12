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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBIFw_QmReuCpbBbaintyMYuKeIOK9Pl1I',
    appId: '1:340414104792:web:8f4707127a4e94d57dc3ad',
    messagingSenderId: '340414104792',
    projectId: 'manul-89d18',
    authDomain: 'manul-89d18.firebaseapp.com',
    storageBucket: 'manul-89d18.appspot.com',
    measurementId: 'G-89FPM9T32H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_lF80AoBAEzzu0B8pks5FWRWUz4UjOMg',
    appId: '1:340414104792:android:316ee0c880d27f677dc3ad',
    messagingSenderId: '340414104792',
    projectId: 'manul-89d18',
    storageBucket: 'manul-89d18.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGUH-EpG0aKeKcFJ7R3zKJ15hiSHVTGG0',
    appId: '1:340414104792:ios:a74bd6e8ba85eef17dc3ad',
    messagingSenderId: '340414104792',
    projectId: 'manul-89d18',
    storageBucket: 'manul-89d18.appspot.com',
    iosBundleId: 'com.sebastiansliwa.manul',
  );
}
