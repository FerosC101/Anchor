// File generated / maintained by FlutterFire CLI and manual setup.
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ── Web ──────────────────────────────────────────────────────────────────
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDShRLVx5V2Mc2qbQHN_823Q83gCo2XpOI',
    appId: '1:472108302995:web:9d2356e97cfc9ff2888366',
    messagingSenderId: '472108302995',
    projectId: 'anchor-81b45',
    authDomain: 'anchor-81b45.firebaseapp.com',
    storageBucket: 'anchor-81b45.firebasestorage.app',
    measurementId: 'G-8JCLYHK7JM',
  );

  // ── Android ──────────────────────────────────────────────────────────────
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAosd75xcOq-yaEwOrCr4a0G1_NmzUzl_I',
    appId: '1:472108302995:android:7e54066b3d78f3db888366',
    messagingSenderId: '472108302995',
    projectId: 'anchor-81b45',
    storageBucket: 'anchor-81b45.firebasestorage.app',
  );

  // ── iOS ──────────────────────────────────────────────────────────────────
  // TODO: Run `flutterfire configure --project=anchor-81b45` to fill in the
  //       iOS-specific apiKey, appId, and iosBundleId values below.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_IOS_API_KEY',
    appId: 'REPLACE_WITH_IOS_APP_ID',
    messagingSenderId: '472108302995',
    projectId: 'anchor-81b45',
    storageBucket: 'anchor-81b45.firebasestorage.app',
    iosBundleId: 'com.anchor.app',
  );

  // ── macOS ─────────────────────────────────────────────────────────────────
  // TODO: Run `flutterfire configure --project=anchor-81b45` to fill in the
  //       macOS-specific apiKey, appId, and bundleId values below.
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'REPLACE_WITH_MACOS_API_KEY',
    appId: 'REPLACE_WITH_MACOS_APP_ID',
    messagingSenderId: '472108302995',
    projectId: 'anchor-81b45',
    storageBucket: 'anchor-81b45.firebasestorage.app',
    iosBundleId: 'com.anchor.app',
  );
}
