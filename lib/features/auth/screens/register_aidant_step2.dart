import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dima_m3ak/features/home/aidant/home_aidant.dart';
import 'package:dima_m3ak/services/auth_api.dart';
import 'package:dima_m3ak/core/enums/user_role.dart';

class RegisterAidantStep2 extends StatefulWidget {
  final String name;
  final String dob;
  final String phone;
  final String email;
  final String password;
  final List<String> helpTypes;
  final List<String> days;
  final String hoursFrom;
  final String hoursTo;
  final bool emergencyAvailable;
  final String city;
  final String gps;
  final String radius;
  final String cin;

  RegisterAidantStep2({
    Key? key,
    required this.name,
    required this.dob,
    required this.phone,
    required this.email,
    required this.password,
    required this.helpTypes,
    required this.days,
    required this.hoursFrom,
    required this.hoursTo,
    required this.emergencyAvailable,
    required this.city,
    required this.gps,
    required this.radius,
    required this.cin,
  }) : super(key: key);

  @override
  State<RegisterAidantStep2> createState() => _RegisterAidantStep2State();
}

class _RegisterAidantStep2State extends State<RegisterAidantStep2> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final TextEditingController _cinController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _acceptedTerms = false;
  String? _selectedCity;

  // Multi-select aide
  final List<String> _helpOptions = [
    'Aide ménagère',
    'Courses et achats',
    'Aide à l’hygiène personnelle',
    'Accompagnement médical',
    'Accompagnement administratif',
    'Accompagnement scolaire',
    'Compagnie et présence',
    'Autre',
  ];

  final List<String> _selectedHelpTypes = [];

  final List<String> _cities = [
    // Casablanca – Settat
  'Casablanca',
  'Mohammedia',
  'Settat',
  'El Jadida',
  'Azemmour',
  'Berrechid',
  'Benslimane',
  'Sidi Bennour',

  // Rabat – Salé – Kénitra
  'Rabat',
  'Salé',
  'Temara',
  'Skhirate',
  'Kenitra',
  'Sidi Slimane',
  'Sidi Kacem',

  // Marrakech – Safi
  'Marrakech',
  'Safi',
  'Essaouira',
  'El Kelâa des Sraghna',
  'Youssoufia',
  'Chichaoua',
  'Rehamna',

  // Fès – Meknès
  'Fes',
  'Meknes',
  'Taza',
  'Sefrou',
  'El Hajeb',
  'Boulemane',
  'Taounate',

  // Tanger – Tétouan – Al Hoceima
  'Tanger',
  'Tetouan',
  'Martil',
  'Fnideq',
  'Mdiq',
  'Chefchaouen',
  'Al Hoceima',
  'Larache',
  'Asilah',
  'Ouezzane',

  // Souss – Massa
  'Agadir',
  'Inezgane',
  'Ait Melloul',
  'Taroudant',
  'Tiznit',
  'Chtouka Ait Baha',

  // Oriental
  'Oujda',
  'Nador',
  'Berkane',
  'Taourirt',
  'Jerada',
  'Guercif',
  'Driouch',

  // Béni Mellal – Khénifra
  'Beni Mellal',
  'Khouribga',
  'Khénifra',
  'Fquih Ben Salah',
  'Azilal',

  // Drâa – Tafilalet
  'Errachidia',
  'Ouarzazate',
  'Zagora',
  'Tinghir',
  'Midelt',

  // Guelmim – Oued Noun
  'Guelmim',
  'Sidi Ifni',
  'Tan-Tan',
  'Assa',

  // Laâyoune – Sakia El Hamra
  'Laayoune',
  'Boujdour',
  'Tarfaya',
  'Es-Semara',

  // Dakhla – Oued Ed-Dahab
  'Dakhla',
  'Aousserd',
  ];

  InputDecoration _inputDecoration(String hint, {Widget? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF0386D0), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  void dispose() {
    _cinController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedHelpTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner au moins une aide')),
      );
      return;
    }

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez accepter les termes et la politique de confidentialité'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.registerWithEmail(
        email: widget.email,
        password: widget.password,
        role: UserRole.aidant,
        profile: {
          'name': widget.name,
          'dob': widget.dob,
          'phone': widget.phone,
          'helpTypes': widget.helpTypes,
          'days': widget.days,
          'hoursFrom': widget.hoursFrom,
          'hoursTo': widget.hoursTo,
          'emergencyAvailable': widget.emergencyAvailable,
          'city': widget.city,
          'gps': widget.gps,
          'radius': widget.radius,
          'cin': widget.cin,
          'selectedCity': _selectedCity,
          'selectedHelpTypes': _selectedHelpTypes,
        },
      ).timeout(const Duration(seconds: 20));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeAidant()),
      );
    } on TimeoutException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion lente. Vérifiez les émulateurs Firebase.')),
      );
    } on FirebaseException catch (e) {
      if (!mounted) return;
      final message = (e.code == 'network-request-failed' || e.code == 'unavailable')
          ? 'Émulateurs Firebase inaccessibles.'
          : 'Échec de l\'inscription.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de l\'inscription.')),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Confirmer vos informations',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A3D91),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ===== Aide (Multi-select) =====
                        const _Label('Type d’aide que vous proposez'),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6FB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _helpOptions.map((help) {
                              final isSelected = _selectedHelpTypes.contains(help);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedHelpTypes.remove(help);
                                    } else {
                                      _selectedHelpTypes.add(help);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF0386D0) : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF0386D0) : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    help,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected ? Colors.white : Colors.black87,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ===== Ville =====
                        const _Label('Ville'),
                        DropdownButtonFormField<String>(
                          value: _selectedCity,
                          items: _cities
                              .map(
                                (city) => DropdownMenuItem(
                                  value: city,
                                  child: Text(city),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCity = value;
                            });
                          },
                          decoration: _inputDecoration(
                            'Sélectionnez votre ville',
                            prefixIcon: const Icon(Icons.location_city),
                          ),
                          validator: (v) => v == null ? 'Champ requis' : null,
                        ),
                        const SizedBox(height: 12),

                        // ===== CIN =====
                        const _Label('Numéro d\'identité (CIN)'),
                        TextFormField(
                          controller: _cinController,
                          decoration: _inputDecoration(
                            'Ex: AB123456',
                            prefixIcon: const Icon(Icons.badge),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
                        ),
                        const SizedBox(height: 12),

                        // ===== Conditions =====
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptedTerms,
                              onChanged: (v) {
                                setState(() => _acceptedTerms = v ?? false);
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'J\'accepte les termes et la politique de confidentialité',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ===== Buttons =====
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFF0A3D91)),
                                  ),
                                  child: const Text(
                                    'Retour',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0A3D91),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: InkWell(
                                onTap: _isLoading ? null : _submit,
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          "S'inscrire",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Image.asset(
              'assets/images/register_bottom.png',
              height: size.height * 0.25,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Label Widget =====
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
