import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY']!,
            authDomain: dotenv.env['AUTH_DOMAIN']!,
            projectId: dotenv.env['PROJECT_ID']!,
            storageBucket: "mymcqappbackend.firebasestorage.app",
            messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
            appId: dotenv.env['APP_ID']!,
            measurementId: dotenv.env['MEASUREMENT_ID']!));
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.env['FIREBASE_API_KEY']!,
            authDomain: dotenv.env['AUTH_DOMAIN']!,
            projectId: dotenv.env['PROJECT_ID']!,
            storageBucket: "mymcqappbackend.firebasestorage.app",
            messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
            appId: dotenv.env['APP_ID']!,
            measurementId: dotenv.env['MEASUREMENT_ID']!));
  }
}
