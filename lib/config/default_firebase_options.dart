import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAGoQybzJqCd5jHydEAiHJ7V2tTKmBBy1M',
    appId: '1:71168357334:web:00229fde690b3ac127aa77',
    messagingSenderId: '71168357334',
    projectId: 'dealerclient-408b4',
    authDomain: 'dealerclient-408b4.firebaseapp.com',
    storageBucket: 'dealerclient-408b4.appspot.com',
    databaseURL: 'https://dealerclient-408b4-default-rtdb.europe-west1.firebasedatabase.app',
    measurementId: 'G-6H06DCPFJ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZgR2iF_6K0dZ9A-mFMEwVB0ddSub9OrA',//
    appId: '1:71168357334:android:c9511218b64a544b27aa77',
    messagingSenderId: '71168357334',//
    projectId: 'dealerclient-408b4',
    storageBucket: 'dealerclient-408b4.appspot.com',

  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
    iosBundleId: '',
  );
}
