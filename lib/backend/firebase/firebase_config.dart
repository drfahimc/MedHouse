import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCot1M8mAEYuElSDUbVgDLDnGBoAbE_jrg",
            authDomain: "mymcqappbackend.firebaseapp.com",
            projectId: "mymcqappbackend",
            storageBucket: "mymcqappbackend.firebasestorage.app",
            messagingSenderId: "283835755172",
            appId: "1:283835755172:web:de0e99728ef151203c1431",
            measurementId: "G-B7H494JWH4"));
  } else {
    await Firebase.initializeApp();
  }
}
