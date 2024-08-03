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
    apiKey: 'AIzaSyAHOrwQiy8uJIweHGKdV391Yagyq3-ka9Q',
    appId: '1:893540752041:android:9450d81eacaf0dead9a7b8',
    messagingSenderId: '893540752041',
    projectId: 'intelli-fridge',
    databaseURL: 'https://intelli-fridge-default-rtdb.firebaseio.com',
    storageBucket: 'intelli-fridge.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6SSiPvieHl-SCwMeYdfSvczidmFDyDdY',
    appId: '1:893540752041:ios:65c147ecc41bb942d9a7b8',
    messagingSenderId: '893540752041',
    projectId: 'intelli-fridge',
    databaseURL: 'https://intelli-fridge-default-rtdb.firebaseio.com',
    storageBucket: 'intelli-fridge.appspot.com',
    iosClientId: '893540752041-n4f6r798965hdut12nvoo5h1f20ntir6.apps.googleusercontent.com',
    iosBundleId: 'com.example.ragl.integreadora',
  );
}
