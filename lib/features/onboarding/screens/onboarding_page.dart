import 'package:flutter/material.dart';
import 'package:dima_m3ak/shared/widgets/app_background.dart';

import 'welcome_screen.dart';
import 'services_screen.dart';
import 'communication_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: navigation vers Login ou Home
      // Navigator.pushReplacement(...)
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        children: [
          WelcomeScreen(onNext: nextPage, index: currentIndex),
          ServicesScreen(onNext: nextPage, index: currentIndex),
          CommunicationScreen(onNext: nextPage, index: currentIndex),
        ],
      ),
    );

  }
}
