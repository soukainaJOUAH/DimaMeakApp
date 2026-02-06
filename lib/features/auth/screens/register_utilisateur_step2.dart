import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dima_m3ak/features/auth/screens/authorization_screen.dart';
import 'package:dima_m3ak/services/auth_api.dart';
import 'package:dima_m3ak/core/enums/user_role.dart';

class RegisterUtilisateurStep2 extends StatefulWidget {
  final String name;
  final String dob;
  final String phone;
  final String email;
  final List<String> handicaps;

  const RegisterUtilisateurStep2({
    super.key,
    required this.name,
    required this.dob,
    required this.phone,
    required this.email,
    required this.handicaps,
  });

  @override
  State<RegisterUtilisateurStep2> createState() => _RegisterUtilisateurStep2State();
}

class _RegisterUtilisateurStep2State extends State<RegisterUtilisateurStep2> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;
  static const bool _devBypassRegistration = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyPhoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _acceptedTerms = false;

  InputDecoration _inputDecoration(String hint, {Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF0386D0), width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red, width: 2)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red, width: 2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_devBypassRegistration) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthorizationScreen()),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez accepter les termes et conditions')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _authService.registerWithEmail(
        email: widget.email,
        password: _passwordController.text,
        role: UserRole.utilisateur,
        profile: {
          'name': widget.name,
          'dob': widget.dob,
          'phone': widget.phone,
          'handicaps': widget.handicaps,
          'emergencyName': _emergencyNameController.text,
          'emergencyPhone': _emergencyPhoneController.text,
          'location': _locationController.text,
        },
      ).timeout(const Duration(seconds: 20));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthorizationScreen()),
      );
    } on TimeoutException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion lente. Réessayez.')),
      );
    } on FirebaseException catch (e) {
      if (!mounted) return;
      final message = (e.code == 'network-request-failed' || e.code == 'unavailable')
          ? 'Émulateurs Firebase inaccessibles.'
          : 'Échec de l\’inscription.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de l’inscription.')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(height: size.height * 0.02),
                      const Text('Confirmer vos informations', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0A3D91))),
                      const SizedBox(height: 12),

                      const _Label('Lieu (ville / adresse)'),
                      TextFormField(
                        controller: _locationController,
                        decoration: _inputDecoration('Entrez ville ou adresse', prefixIcon: const Icon(Icons.location_on)),
                        validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
                      ),
                      const SizedBox(height: 12),

                      const _Label('Mot de passe'),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration('Entrez votre mot de passe', prefixIcon: const Icon(Icons.lock), suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF0386D0)), onPressed: () => setState(() => _obscurePassword = !_obscurePassword))),
                        validator: (value) => value == null || value.length < 6 ? 'Minimum 6 caractères' : null,
                      ),
                      const SizedBox(height: 12),

                      const _Label('Confirmer le mot de passe'),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration('Confirmez votre mot de passe', prefixIcon: const Icon(Icons.lock)),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Champ requis';
                          if (value != _passwordController.text) return 'Les mots de passe ne correspondent pas';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      const _Label('Personne à contacter en cas d\'urgence'),
                      TextFormField(controller: _emergencyNameController, decoration: _inputDecoration('Nom du contact', prefixIcon: const Icon(Icons.person)), validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null),
                      const SizedBox(height: 12),
                      TextFormField(controller: _emergencyPhoneController, keyboardType: TextInputType.phone, decoration: _inputDecoration('Téléphone du contact', prefixIcon: const Icon(Icons.phone)), validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null),
                      const SizedBox(height: 12),

                      Row(children: [
                        Checkbox(value: _acceptedTerms, onChanged: (v) => setState(() => _acceptedTerms = v ?? false)),
                        const Expanded(child: Text('J\'accepte les termes et conditions', style: TextStyle(fontSize: 14))),
                      ]),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF0A3D91))),
                                child: const Text('Retour', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0A3D91))),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: _isLoading ? null : _submit,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)]), borderRadius: BorderRadius.circular(12)),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                      )
                                    : const Text("S'inscrire", style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.05),
                    ]),
                  ),
                ),
              ),
            ),

            // bottom image
            Image.asset('assets/images/register_bottom.png', height: size.height * 0.25, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}

// small label widget
class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w500)));
  }
}
