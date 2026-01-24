import 'package:flutter/material.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🔹 Theme عام للتطبيق كامل
      theme: ThemeData(
        fontFamily: 'Poppins', // ⬅️ الخط اللي درناه ف pubspec.yaml
      ),

      home: const SplashScreen(),
    );
  }
}
