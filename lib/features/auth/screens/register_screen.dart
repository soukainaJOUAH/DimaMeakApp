import 'package:flutter/material.dart';
import 'register_utilisateur.dart';
import 'register_aidant.dart';

enum UserRole { utilisateur, aidant }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0A3D91)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                /// 🔹 CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Sélectionnez votre situation',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),

                        SizedBox(height: size.height * 0.03),

                        /// 🔹 Utilisateur
                        _RoleCard(
                          title: 'Utilisateur',
                          description:
                              'Personne en situation de handicap qui cherche de l’aide',
                          icon: Icons.accessible,
                          selected: _selectedRole == UserRole.utilisateur,
                          onTap: () {
                            setState(() {
                              _selectedRole = UserRole.utilisateur;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        /// 🔹 Aidant
                        _RoleCard(
                          title: 'Aidant',
                          description:
                              'Personne qui propose des services d’accompagnement',
                          icon: Icons.handshake,
                          selected: _selectedRole == UserRole.aidant,
                          onTap: () {
                            setState(() {
                              _selectedRole = UserRole.aidant;
                            });
                          },
                        ),

                        SizedBox(height: size.height * 0.04),

                        /// 🔹 Button Continuer
                        InkWell(
                          onTap: _selectedRole == null
                              ? null
                              : () {
                                  if (_selectedRole ==
                                      UserRole.utilisateur) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const RegisterUtilisateur(),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const RegisterAidant(),
                                      ),
                                    );
                                  }
                                },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 48,
                            width: double.infinity,
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

                        SizedBox(height: size.height * 0.03),
                      ],
                    ),
                  ),
                ),

                /// 🔹 IMAGE BOTTOM (ديما لاصقة لتحت)
                Image.asset(
                  'assets/images/register_bottom.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 🔹 ROLE CARD
class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color(0xFF0A3D91)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0A3D91)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
