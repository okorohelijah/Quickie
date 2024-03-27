import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickie/homePage.dart';
import 'package:quickie/signUpPage.dart';

import 'firebase_options.dart';
import 'loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quickie',
      initialRoute: '/home',
      routes: {
        '/': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(), // Ensure LoginPage is properly defined
      },
    );
  }
}