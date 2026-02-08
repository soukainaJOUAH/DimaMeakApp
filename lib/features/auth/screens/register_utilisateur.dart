import 'package:flutter/material.dart';
import 'package:dima_m3ak/features/auth/screens/authorization_screen.dart';
import 'register_utilisateur_step2.dart';

class RegisterUtilisateur extends StatefulWidget {
  const RegisterUtilisateur({super.key});

  @override
  State<RegisterUtilisateur> createState() =>
      _RegisterUtilisateurState();
}

class _RegisterUtilisateurState extends State<RegisterUtilisateur> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // controllers / extra fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyPhoneController = TextEditingController();

  bool _acceptedTerms = false;

  // step0 validator (personal info only)
  bool _validateStep0() {
    if (_nameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _selectedHandicaps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs requis de la première page.')),
      );
      return false;
    }
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email invalide')));
      return false;
    }
    return true;
  }

  // handicap options (multi-select)
  final List<Map<String, dynamic>> handicaps = [
    {'label': 'Mobilité', 'icon': Icons.accessible},
    {'label': 'Visuel', 'icon': Icons.visibility_off},
    {'label': 'Auditif', 'icon': Icons.hearing_disabled},
    {'label': 'Mental (léger)', 'icon': Icons.psychology},
  ];
  final Set<String> _selectedHandicaps = {};

  final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

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

                        // Step 0 fields
                        /// 🔹 Nom
                        const _Label('Nom complet'),
                        TextFormField(
                          controller: _nameController,
                          decoration: _inputDecoration('Entrez votre nom', prefixIcon: const Icon(Icons.person)),
                        ),

                        const SizedBox(height: 12),

                        /// 🔹 Date de naissance
                        const _Label('Date de naissance'),
                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          decoration: _inputDecoration('Sélectionnez la date de naissance', prefixIcon: const Icon(Icons.cake)),
                          onTap: () async {
                            final today = DateTime.now();
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(today.year - 25),
                              firstDate: DateTime(1900),
                              lastDate: today,
                            );
                            if (picked != null) {
                              _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
                            }
                          },
                        ),

                        const SizedBox(height: 12),

                        /// 🔹 Phone number
                        const _Label('Téléphone'),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _inputDecoration('Entrez votre numéro de téléphone', prefixIcon: const Icon(Icons.phone)),
                        ),

                        const SizedBox(height: 12),

                        /// 🔹 Email (required)
                        const _Label('Email'),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration('Entrez votre email', prefixIcon: const Icon(Icons.email)),
                        ),

                        const SizedBox(height: 12),

                        /// 🔹 Type de handicap (choix multiple)
                        const _Label('Type de situation de handicap'),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6FB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: handicaps.map((h) {
                              final label = h['label'] as String;
                              final isSelected = _selectedHandicaps.contains(label);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedHandicaps.remove(label);
                                    } else {
                                      _selectedHandicaps.add(label);
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        h['icon'],
                                        size: 16,
                                        color: isSelected ? Colors.white : const Color(0xFF0A3D91),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        label,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isSelected ? Colors.white : Colors.black87,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const SizedBox(height: 24),

                        // Navigation: push Step 2 when Step 0 is valid
                        InkWell(
                          onTap: () {
                            if (_validateStep0()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterUtilisateurStep2(
                                    name: _nameController.text,
                                    dob: _dobController.text,
                                    phone: _phoneController.text,
                                    email: _emailController.text,
                                    handicaps: _selectedHandicaps.toList(),
                                  ),
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
                              gradient: const LinearGradient(colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)]),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('Suivant', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),

                        SizedBox(height: size.height * 0.05),

                        // bottom image stays fixed at the bottom of the page
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
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
