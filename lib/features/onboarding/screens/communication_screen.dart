import 'package:flutter/material.dart';
import 'package:dima_m3ak/features/auth/screens/login_screen.dart';
import '../widgets/onboarding_template.dart';



class CommunicationScreen extends StatelessWidget {
  final VoidCallback onNext;
  final int index;

  const CommunicationScreen({
    super.key,
    required this.onNext,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Communiquez Facilement',
      subtitle: 'Utilisez la voix pour naviguer, dictez vos messages '
          'et accédez au bouton SOS.',
      onNext: () => _goToLogin(context),
      onSkip: () => _goToLogin(context),
      index: index,
      buttonText: 'Commencer',
      showSkip: false,
    );
  }

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, __) =>  LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          );

          return SlideTransition(
            position: slideAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

