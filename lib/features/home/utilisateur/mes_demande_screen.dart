import 'package:flutter/material.dart';

class MesDemandesScreen extends StatelessWidget {
  const MesDemandesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('Mes demandes', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
