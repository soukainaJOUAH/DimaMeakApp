import 'package:flutter/material.dart';
import 'package:dima_m3ak/core/enums/user_role.dart';
import '../utilisateur/home_utilisateur.dart';
import '../aidant/home_aidant.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isVoiceEnabled;
  final UserRole role;

  const HomeScreen({
    super.key,
    required this.isVoiceEnabled,
    required this.role,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.isVoiceEnabled) {
      // 🔊 Voice logic later (مرحلة 3)
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (widget.role == UserRole.utilisateur) {
      body =  HomeUtilisateur();
    } else {
      body =  HomeAidant();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),


      /// 🔹 Body حسب role
      body: body,

      
    );
  }
}
