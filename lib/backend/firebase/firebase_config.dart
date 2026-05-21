import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD_21PIfL1sExuZ6JCpEWaORctDt6hqHxE",
            authDomain: "simple-notify-app-97757.firebaseapp.com",
            projectId: "simple-notify-app-97757",
            storageBucket: "simple-notify-app-97757.firebasestorage.app",
            messagingSenderId: "645346731287",
            appId: "1:645346731287:web:4efe158cf27f9b6efdc352",
            measurementId: "G-JSYT1SBY3L"));
  } else {
    await Firebase.initializeApp();
  }
}
