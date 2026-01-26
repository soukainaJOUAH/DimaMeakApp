import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final sizePadding = const EdgeInsets.symmetric(horizontal: 24);

  String? selectedRole; // Utilisateur / Aidant
  String? selectedHandicap;

  final List<String> roles = ['Utilisateur', 'Aidant'];
  final List<String> handicaps = [
    'Handicap visuel',
    'Handicap moteur',
    'Handicap auditif',
    'Handicap mental',
    'Autre',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: sizePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.04),

                // 🔹 Title
                const Center(
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A3D91),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                const Center(
                  child: Text(
                    'Remplissez vos informations',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                _label('Nom'),
                _input('Text'),

                SizedBox(height: size.height * 0.02),

                _label('Prénom'),
                _input('Text'),

                SizedBox(height: size.height * 0.02),

                // 🔹 Role
                _label('Vous êtes'),
                _dropdown(
                  value: selectedRole,
                  hint: 'Sélectionnez votre rôle',
                  items: roles,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                      if (value == 'Aidant') {
                        selectedHandicap = null;
                      }
                    });
                  },
                ),

                SizedBox(height: size.height * 0.02),

                // 🔹 Handicap (only if Utilisateur)
                if (selectedRole == 'Utilisateur') ...[
                  _label('Votre situation'),
                  _dropdown(
                    value: selectedHandicap,
                    hint: 'Sélectionnez votre situation',
                    items: handicaps,
                    onChanged: (value) {
                      setState(() {
                        selectedHandicap = value;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                ],

                _label('Email'),
                _input('example@gmail.com'),

                SizedBox(height: size.height * 0.02),

                _label('Mot de passe'),
                _input('********', obscure: true),

                SizedBox(height: size.height * 0.04),

                // 🔹 Register Button
                InkWell(
                  onTap: () {
                    // TODO: Register logic
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0A3D91),
                          Color(0xFF0E7C7B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Widgets helpers
  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _input(String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF4F6FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint),
          isExpanded: true,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
