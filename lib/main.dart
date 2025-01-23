import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB4t7PSSaxhQsH6owsqhUolTMCMkxbZqJ4",
          authDomain: "myproject-11cec.firebaseapp.com",
          projectId: "myproject-11cec",
          storageBucket: "myproject-11cec.firebasestorage.app",
          messagingSenderId: "525086392126",
          appId: "1:525086392126:web:6a3568b4089423564c366f",
          measurementId: "G-ZTRPEHF61Z"));
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return  LoginScreen(); 
            }
          },
        ),
      ),
    );
  }
}
