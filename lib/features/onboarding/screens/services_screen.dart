import 'package:flutter/material.dart';
import '../widgets/onboarding_template.dart';
import 'package:dima_m3ak/features/auth/screens/login_screen.dart';

class ServicesScreen extends StatelessWidget {
  final VoidCallback onNext;
  final int index;

  static const String _buttonText = 'Suivant';

  const ServicesScreen({
    super.key,
    required this.onNext,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'Services Géolocalisés',
      subtitle: 'Trouvez rapidement les services et associations\n'
          'près de vous grâce à la géolocalisation.',
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
      buttonText: _buttonText,
      showSkip: true,
      showDots: true,
      totalDots: 3,
    );
  }
}
