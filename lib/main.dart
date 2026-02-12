import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'features/splash/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'core/services/sos_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const bool _useEmulators = true;
  if (kDebugMode && _useEmulators) {
    final host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';
    FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  }

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

      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            const SosOverlay(),
          ],
        );
      },
      home: const SplashScreen(),
    );
  }
}
