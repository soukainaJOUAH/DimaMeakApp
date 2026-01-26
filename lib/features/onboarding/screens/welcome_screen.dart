import 'package:flutter/material.dart';
import '../../auth/screens/authorization_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final int index;

  const WelcomeScreen({
    super.key,
    required this.onNext,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                // 🔹 Top image section
                Container(
                  height: size.height * 0.45,
                  color: Colors.white,
                  padding: EdgeInsets.all(size.width * 0.04),
                  child: Image.asset(
                    'assets/images/onboarding_1.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // 🔹 Curved + bottom section
                ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.06,
                      size.height * 0.06,
                      size.width * 0.06,
                      size.height * 0.04,
                    ),
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
                    child: Column(
                      children: [
                        Text(
                          'Bienvenue sur Dima Meak',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.075,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: size.height * 0.015),

                        Text(
                          'Votre guide des services pour personnes\n'
                          'en situation de handicap au Maroc',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: size.width * 0.045,
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // 🔹 Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _Dot(isActive: index == 0),
                            _Dot(isActive: index == 1),
                            _Dot(isActive: index == 2),
                          ],
                        ),

                        SizedBox(height: size.height * 0.03),

                        // 🔹 Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: onNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF0E7C7B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Suivant',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.015),

                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AuthorizationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Passer',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 🔹 Dot widget
class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white38,
        shape: BoxShape.circle,
      ),
    );
  }
}

// 🔹 Curve clipper
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.06);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height * 0.06,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
