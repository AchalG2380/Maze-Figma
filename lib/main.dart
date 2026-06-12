import 'package:flutter/material.dart';
import 'package:maze/onboarding/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Maze",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(1, 4, 31, 1),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
