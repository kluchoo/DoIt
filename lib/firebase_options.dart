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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAst345fy9oWDaFThJ6-kZ90a3ept2f7I',
    appId: '1:1085362780932:android:57e01e9bf27c185779ae51',
    messagingSenderId: '1085362780932',
    projectId: 'do-it-777',
    databaseURL:
        'https://do-it-777-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'do-it-777.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCd4ixiw6QJ5ZSEoGyEDqYQSLJPvo2pDBM',
    appId: '1:1085362780932:ios:80f9bd3c2116941379ae51',
    messagingSenderId: '1085362780932',
    projectId: 'do-it-777',
    databaseURL:
        'https://do-it-777-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'do-it-777.firebasestorage.app',
    iosBundleId: 'com.example.doIt',
  );
}