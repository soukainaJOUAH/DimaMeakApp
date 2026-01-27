import 'package:flutter/material.dart';
import 'package:dima_m3ak/features/auth/screens/register_screen.dart';
import 'package:dima_m3ak/features/home/screens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.5,
        ),
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
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
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
                SizedBox(height: size.height * 0.04),

                const Text(
                  'Connexion',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A3D91),
                  ),
                ),

                SizedBox(height: size.height * 0.008),

                const Text(
                  'Connectez-vous à votre compte',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            _inputDecoration('exemple@gmail.com'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email obligatoire';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Email invalide (ex: nom@gmail.com)';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: size.height * 0.02),

                      const Text(
                        'Mot de passe',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration(
                          'Entrez votre mot de passe',
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mot de passe obligatoire';
                          }
                          if (value.length < 6) {
                            return 'Minimum 6 caractères';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: size.height * 0.01),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Mot de passe oublié ?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0386D0),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          }

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
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Vous n’avez pas encore de compte ? ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'S’inscrire',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0386D0),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Ou connectez-vous avec',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      SizedBox(height: size.height * 0.02),

                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: 24,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Continuer avec Google',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // 🔹 Bottom design (رجع كيفما كان)
                SizedBox(
                  height: size.height * 0.30,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipPath(
                          clipper: TopCurveClipper(),
                          child: Container(
                            height: size.height * 0.20,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF0A3D91),
                                  Color(0xFF0E7C7B),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/login_bottom.png',
                          height: size.height * 0.24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
