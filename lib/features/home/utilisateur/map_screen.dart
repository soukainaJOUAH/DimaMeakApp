import 'package:flutter/material.dart';
// Simple placeholder pour la carte
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Carte',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
