import 'package:flutter/material.dart';

class RegisterUtilisateur extends StatefulWidget {
  const RegisterUtilisateur({super.key});

  @override
  State<RegisterUtilisateur> createState() =>
      _RegisterUtilisateurState();
}

class _RegisterUtilisateurState extends State<RegisterUtilisateur> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  String? _selectedHandicap;

  final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final List<Map<String, dynamic>> handicaps = [
    {
      'label': 'Handicap moteur',
      'icon': Icons.accessible,
    },
    {
      'label': 'Handicap visuel',
      'icon': Icons.visibility_off,
    },
    {
      'label': 'Handicap auditif',
      'icon': Icons.hearing_disabled,
    },
    {
      'label': 'Handicap mental',
      'icon': Icons.psychology,
    },
    {
      'label': 'Autre',
      'icon': Icons.more_horiz,
    },
  ];

  InputDecoration _inputDecoration(String hint,
      {Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),

      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF0386D0),
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: Colors.red, width: 2),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: Colors.red, width: 2),
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.02),

                      const Text(
                        'Créer un compte',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A3D91),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Informations utilisateur',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      /// 🔹 Nom
                      const _Label('Nom complet'),
                      TextFormField(
                        decoration: _inputDecoration(
                          'Entrez votre nom',
                          prefixIcon:
                              const Icon(Icons.person),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Champ requis'
                                : null,
                      ),

                      const SizedBox(height: 12),

                      /// 🔹 Email
                      const _Label('Email'),
                      TextFormField(
                        keyboardType:
                            TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          'Entrez votre email',
                          prefixIcon:
                              const Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Email requis';
                          }
                          if (!emailRegex
                              .hasMatch(value)) {
                            return 'Email invalide';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      /// 🔹 Type de handicap
                      const _Label(
                          'Type de situation de handicap'),
                      DropdownButtonFormField<String>(
                        value: _selectedHandicap,
                        decoration: _inputDecoration(
                          'Sélectionnez votre situation',
                          prefixIcon: const Icon(
                              Icons.accessible),
                        ),
                        items: handicaps.map((h) {
                          return DropdownMenuItem<String>(
                            value: h['label'],
                            child: Row(
                              children: [
                                Icon(
                                  h['icon'],
                                  size: 18,
                                  color:
                                      const Color(0xFF0A3D91),
                                ),
                                const SizedBox(width: 10),
                                Text(h['label']),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedHandicap = value;
                          });
                        },
                        validator: (value) =>
                            value == null
                                ? 'Champ requis'
                                : null,
                      ),

                      const SizedBox(height: 12),

                      /// 🔹 Mot de passe
                      const _Label('Mot de passe'),
                      TextFormField(
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration(
                          'Entrez votre mot de passe',
                          prefixIcon:
                              const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  const Color(0xFF0386D0),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) =>
                            value == null ||
                                    value.length < 6
                                ? 'Minimum 6 caractères'
                                : null,
                      ),

                      SizedBox(height: size.height * 0.04),

                      /// 🔹 Button
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!
                              .validate()) {
                            // NEXT STEP
                          }
                        },
                        borderRadius:
                            BorderRadius.circular(12),
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient:
                                const LinearGradient(
                              colors: [
                                Color(0xFF0A3D91),
                                Color(0xFF0E7C7B),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Continuer',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),

                /// 🔹 Bottom image (بحال register_screen)
                Image.asset(
                  'assets/images/register_bottom.png',
                  height: size.height * 0.25,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
