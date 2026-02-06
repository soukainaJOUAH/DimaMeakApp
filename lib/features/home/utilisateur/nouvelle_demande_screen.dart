import 'package:flutter/material.dart';

class NouvelleDemandeScreen extends StatelessWidget {
  const NouvelleDemandeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('Nouvelle demande', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
