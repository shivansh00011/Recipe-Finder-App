import 'package:dishcovery/pages/intro.dart';
import 'package:dishcovery/pages/home.dart'; // Ensure this import points to your HomePage
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase initialization
  await Hive.initFlutter();
  await Hive.openBox('saved');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), // Listen to auth state
        builder: (context, snapshot) {
          // Handle connection states
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // If the user is logged in, show the home page
              return const HomePage(); 
            } else if (snapshot.hasError) {
              // Handle errors
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for authentication check
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // If no user is logged in, show the intro page
          return const IntroPage();
        },
      ),
    );
  }
}
