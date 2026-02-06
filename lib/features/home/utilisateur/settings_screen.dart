import 'package:flutter/material.dart';
// Simple placeholder pour les paramètres
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Paramètres',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
