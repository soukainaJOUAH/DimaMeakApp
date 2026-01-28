import 'package:flutter/material.dart';
import 'package:dima_m3ak/features/home/screens/home_screen.dart';
import 'package:dima_m3ak/core/enums/user_role.dart';


class RegisterAidant extends StatefulWidget {
  const RegisterAidant({super.key});

  @override
  State<RegisterAidant> createState() => _RegisterAidantState();
}

class _RegisterAidantState extends State<RegisterAidant> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  String? _selectedService;
  String? _selectedCity;

  final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final List<Map<String, dynamic>> services = [
    {'label': 'Accompagnement médical', 'icon': Icons.local_hospital},
    {'label': 'Aide à la mobilité', 'icon': Icons.directions_walk},
    {'label': 'Aide administrative', 'icon': Icons.description},
    {'label': 'Soutien scolaire', 'icon': Icons.school},
    {'label': 'Coiffure / soins personnels', 'icon': Icons.content_cut},
    {'label': 'Autre', 'icon': Icons.more_horiz},
  ];

  final List<String> villes = [
    'Casablanca',
    'Rabat',
    'Marrakech',
    'Fès',
    'Tanger',
    'Agadir',
    'Oujda',
    'Meknès',
    'Salè',
    'Kenitra',
    'Nador',
    'El Jadida',
    'Safi',
    'Khouribga',
    'Bèni Mellal',
    'Taza',
    'Settat',
    'Ksar El Kebir',
    'Larache',
    'Guelmim',
    'Tiznit',
    'Ouarzazate',
    'Dakhla',
    'Laayoune',
    'Ifrane',
    'Azrou',
    'Chefchaouen',
    'Sidi Kacem',
    'Sidi Slimane',
  ];

  InputDecoration _inputDecoration(
    String hint, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
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
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                        ),
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
                              'Informations aidant',
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
                                prefixIcon: const Icon(Icons.person),
                              ),
                              validator: (v) =>
                                  v == null || v.isEmpty
                                      ? 'Champ requis'
                                      : null,
                            ),

                            const SizedBox(height: 12),

                            /// 🔹 Email
                            const _Label('Email'),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration(
                                'Entrez votre email',
                                prefixIcon: const Icon(Icons.email),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Email requis';
                                }
                                if (!emailRegex.hasMatch(v)) {
                                  return 'Email invalide';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            /// 🔹 Service
                            const _Label('Service proposé'),
                            DropdownButtonFormField<String>(
                              value: _selectedService,
                              decoration: _inputDecoration(
                                'Choisissez un service',
                                prefixIcon:
                                    const Icon(Icons.handshake),
                              ),
                              items: services
                                  .map<DropdownMenuItem<String>>(
                                      (s) {
                                return DropdownMenuItem<String>(
                                  value: s['label'] as String,
                                  child: Row(
                                    children: [
                                      Icon(
                                        s['icon'] as IconData,
                                        size: 18,
                                        color: const Color(0xFF0A3D91),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(s['label'] as String),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedService = value;
                                });
                              },
                              validator: (value) =>
                                  value == null ? 'Champ requis' : null,
                            ),

                            const SizedBox(height: 12),

                            /// 🔹 Ville
                            const _Label('Ville'),
                            DropdownButtonFormField<String>(
                              value: _selectedCity,
                              decoration: _inputDecoration(
                                'Sélectionnez votre ville',
                                prefixIcon:
                                    const Icon(Icons.location_on),
                              ),
                              items: villes
                                  .map<DropdownMenuItem<String>>(
                                      (v) {
                                return DropdownMenuItem<String>(
                                  value: v,
                                  child: Text(v),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCity = value;
                                });
                              },
                              validator: (value) =>
                                  value == null ? 'Ville requise' : null,
                            ),

                            const SizedBox(height: 12),

                            /// 🔹 Mot de passe
                            const _Label('Mot de passe'),
                            TextFormField(
                              obscureText: _obscurePassword,
                              decoration: _inputDecoration(
                                'Entrez votre mot de passe',
                                prefixIcon: const Icon(Icons.lock),
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
                              validator: (v) =>
                                  v == null || v.length < 6
                                      ? 'Minimum 6 caractères'
                                      : null,
                            ),

                            SizedBox(height: size.height * 0.04),

                            /// 🔹 Button
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>  HomeScreen(
                                        isVoiceEnabled: false,
                                        role: UserRole.aidant,
                                      ),
                                    ),
                                  );
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
                                  'S\'inscrire',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.04),
                          ],
                        ),
                      ),

                      /// 🔹 Bottom image (ديما لتحت)
                      Image.asset(
                        'assets/images/register_bottom.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
