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
    apiKey: 'AIzaSyDbJPTDyxRCopYNxCS0dR-FhZUZlxBbDgM',
    appId: '1:92218904866:web:204ea0042058187602957b',
    messagingSenderId: '92218904866',
    projectId: 'app-flash-cards',
    authDomain: 'app-flash-cards.firebaseapp.com',
    storageBucket: 'app-flash-cards.appspot.com',
    measurementId: 'G-M5WQNE7EYJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrtLRdgDpDgYlNPDRgkSp184kACXo5geo',
    appId: '1:92218904866:android:a35371ac228e95f002957b',
    messagingSenderId: '92218904866',
    projectId: 'app-flash-cards',
    storageBucket: 'app-flash-cards.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkV6U-Sndc3qnRCa90tDT9N1QA_8dPKYI',
    appId: '1:92218904866:ios:dea66388690faa9002957b',
    messagingSenderId: '92218904866',
    projectId: 'app-flash-cards',
    storageBucket: 'app-flash-cards.appspot.com',
    iosClientId: '92218904866-g0s896d39erlnhajorgeohhhu8sa42ge.apps.googleusercontent.com',
    iosBundleId: 'com.example.flashCardLearnEnglish',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkV6U-Sndc3qnRCa90tDT9N1QA_8dPKYI',
    appId: '1:92218904866:ios:dea66388690faa9002957b',
    messagingSenderId: '92218904866',
    projectId: 'app-flash-cards',
    storageBucket: 'app-flash-cards.appspot.com',
    iosClientId: '92218904866-g0s896d39erlnhajorgeohhhu8sa42ge.apps.googleusercontent.com',
    iosBundleId: 'com.example.flashCardLearnEnglish',
  );
}
