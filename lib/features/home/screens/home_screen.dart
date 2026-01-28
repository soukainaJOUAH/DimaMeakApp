import 'package:flutter/material.dart';
import 'package:dima_m3ak/core/enums/user_role.dart';
import '../utilisateur/home_utilisateur.dart';
import '../aidant/home_aidant.dart';


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
      body = const HomeUtilisateur();
    } else {
      body = const HomeAidant();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      /// 🔹 AppBar (مشترك)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none),
          color: Colors.black87,
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, color: Colors.black54),
            ),
          ),
        ],
      ),

      /// 🔹 Body حسب role
      body: body,

      /// 🔹 Bottom Navigation (مشترك)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0E7C7B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
