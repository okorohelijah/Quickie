import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickie/homePage.dart';
import 'package:quickie/signUpPage.dart';

import 'firebase_options.dart';
import 'loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quickie',
      initialRoute: '/login',
      routes: {
        '/': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(), // Ensure LoginPage is properly defined
        // '/addCardDetails': (context) => PaymentScreen(),
      },
    );
  }
}