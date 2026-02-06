import 'package:flutter/material.dart';

class HomeAidant extends StatelessWidget {
  const HomeAidant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accueil — Aidant')),
      body: const Center(
        child: Text(
          'Bienvenue sur la page d\'accueil Aidant',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
