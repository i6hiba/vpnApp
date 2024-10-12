import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return webFirebaseOptions;
    } else {
      return const FirebaseOptions(
        
        apiKey: 'YOUR_API_KEY',
        appId: 'YOUR_APP_ID',
        messagingSenderId: 'Y388062342944',
        projectId: 'vpn0-30990',
      );
    }
  }

  static FirebaseOptions webFirebaseOptions = const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: '388062342944',
    projectId: 'vpn0-30990',
  );
}