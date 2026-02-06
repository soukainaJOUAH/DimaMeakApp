import 'package:flutter/material.dart';
import '../../auth/screens/authorization_screen.dart';
import '../widgets/onboarding_template.dart';
import 'package:dima_m3ak/features/auth/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final int index;

  const WelcomeScreen({
    super.key,
    required this.onNext,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Bienvenue sur Dima Meak',
      subtitle: 'Votre guide des services pour personnes\n'
          'en situation de handicap au Maroc',
      onNext: onNext,
      onSkip: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
      index: index,
    );
  }
}
