import 'package:flutter/material.dart';
import 'package:dima_m3ak/features/home/aidant/home_aidant.dart';
import 'register_aidant_step2.dart';

class RegisterAidant extends StatefulWidget {
  const RegisterAidant({super.key});

  @override
  State<RegisterAidant> createState() => _RegisterAidantState();
}

class _RegisterAidantState extends State<RegisterAidant> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // controllers / fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _gpsController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();

  // added: controllers referenced in dispose()
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyPhoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // added: missing fields
  late TextEditingController _hoursFromController;
  late TextEditingController _hoursToController;
  late Set<String> _selectedDays;
  bool _emergencyAvailable = false;

  bool _acceptedTerms = false;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // types of help
  final List<Map<String, dynamic>> helpTypes = [
    {'label': 'Accompagnement', 'icon': Icons.person_add},
    {'label': 'Transport', 'icon': Icons.local_taxi},
    {'label': 'Assistance quotidienne', 'icon': Icons.cleaning_services},
    {'label': 'Aide médicale légère', 'icon': Icons.medical_services},
  ];
  final Set<String> _selectedHelpTypes = {};

  // city list (Morocco)
  final List<String> moroccoCities = [
    'Casablanca','Rabat','Fès','Marrakech','Tanger','Agadir','Meknès','Tétouan','Oujda',
    'Kénitra','El Jadida','Safi','Khouribga','Beni Mellal','Settat','Khemisset','Nador','Chefchaouen','Essaouira'
  ];
  String? _selectedCity;

  InputDecoration _inputDecoration(String hint, {Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  bool _validateStep0() {
    if (_nameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez remplir tous les champs requis de la première page.')));
      return false;
    }
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email invalide')));
      return false;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Minimum 6 caractères pour le mot de passe')));
      return false;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Les mots de passe ne correspondent pas')));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _hoursFromController = TextEditingController();
    _hoursToController = TextEditingController();
    _selectedDays = {};
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
                      const Text(
                        'Créer un compte',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0A3D91)),
                      ),
                      const SizedBox(height: 6),
                      const Text('Informations aidant', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black54)),
                      SizedBox(height: size.height * 0.03),

                      // Full name
                      const _Label('Nom complet'),
                      TextFormField(controller: _nameController, decoration: _inputDecoration('Entrez votre nom', prefixIcon: const Icon(Icons.person))),
                      const SizedBox(height: 12),

                      // DOB
                      const _Label('Date de naissance'),
                      TextFormField(
                        controller: _dobController,
                        readOnly: true,
                        decoration: _inputDecoration('Sélectionnez la date de naissance', prefixIcon: const Icon(Icons.cake)),
                        onTap: () async {
                          final today = DateTime.now();
                          final picked = await showDatePicker(context: context, initialDate: DateTime(today.year - 30), firstDate: DateTime(1900), lastDate: today);
                          if (picked != null) _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
                        },
                      ),
                      const SizedBox(height: 12),

                      // Phone
                      const _Label('Téléphone'),
                      TextFormField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: _inputDecoration('Entrez votre numéro de téléphone', prefixIcon: const Icon(Icons.phone))),
                      const SizedBox(height: 12),

                      // Email (required)
                      const _Label('Email'),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration('Entrez votre email', prefixIcon: const Icon(Icons.email)),
                      ),
                      const SizedBox(height: 12),

                      // Password
                      const _Label('Mot de passe'),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration('Entrez votre mot de passe', prefixIcon: const Icon(Icons.lock), suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF0386D0)), onPressed: () => setState(() => _obscurePassword = !_obscurePassword))),
                        validator: (value) => value == null || value.length < 6 ? 'Minimum 6 caractères' : null,
                      ),
                      const SizedBox(height: 12),

                      // Confirm password
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

                      

                      // Navigation controls -> Next opens step2
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          if (_validateStep0()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterAidantStep2(
                                  name: _nameController.text,
                                  dob: _dobController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                    password: _passwordController.text,
                                  helpTypes: _selectedHelpTypes.toList(),
                                  days: _selectedDays.toList(),
                                  hoursFrom: _hoursFromController.text,
                                  hoursTo: _hoursToController.text,
                                  emergencyAvailable: _emergencyAvailable,
                                  city: _selectedCity ?? '',
                                  gps: _gpsController.text,
                                  radius: _radiusController.text,
                                  cin: _cinController.text,
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
                          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)]), borderRadius: BorderRadius.circular(12)),
                          child: const Text('Suivant', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      // bottom image stays fixed at the bottom of the page
                      Image.asset('assets/images/register_bottom.png', height: size.height * 0.25, fit: BoxFit.contain),
                    ]),
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
    _locationController.dispose();
    _hoursFromController.dispose();
    _hoursToController.dispose();
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
      child: Text(text, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }
}
