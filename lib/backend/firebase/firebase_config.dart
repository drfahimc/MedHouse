import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.env['firebase_api_key'],
            authDomain: dotenv.env['authDomain'],
            projectId: dotenv.env['projectId'],
            storageBucket: "mymcqappbackend.firebasestorage.app",
            messagingSenderId: dotenv.env['messagingSenderId'],
            appId: dotenv.env['appId'],
            measurementId: dotenv.env['measurementId']));
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.env['firebase_api_key'],
            authDomain: dotenv.env['authDomain'],
            projectId: dotenv.env['projectId'],
            storageBucket: dotenv.env['storageBucket'],
            messagingSenderId: dotenv.env['messagingSenderId'],
            appId: dotenv.env['appId'],
            measurementId: dotenv.env['measurementId']));
  }
}
