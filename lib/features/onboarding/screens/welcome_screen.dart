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
    return Column(
      children: [
        // 🔹 Top white part (image)
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(6), // ⬅️ هامش خفيف بحال Figma
              child: SizedBox.expand(
                child: Image.asset(
                  'assets/images/onboarding_1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),


        // 🔹 Curved + bottom section
        Expanded(
          flex: 5,
          child: ClipPath(
            clipper: TopCurveClipper(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
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
                  const Text(
                    'Bienvenue sur Dima Meak',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Votre guide des services pour personnes\n'
                    'en situation de handicap au Maroc',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),

                  const Spacer(),

                  // 🔹 Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Dot(isActive: index == 0),
                      _Dot(isActive: index == 1),
                      _Dot(isActive: index == 2),
                    ],
                  ),

                  const SizedBox(height: 20),

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
                        style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthorizationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Passer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400, // Regular
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

// 🔹 Curve clipper (موحّدة)
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 30);
    path.quadraticBezierTo(
      size.width / 2,
      10,
      size.width,
      30,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
