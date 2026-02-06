import 'package:flutter/material.dart';

class ParametersScreen extends StatelessWidget {
  const ParametersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text('Paramètres', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Expanded(
          child: Center(child: Text('Paramètres (placeholders)')),
        ),
      ],
    );
  }
}
