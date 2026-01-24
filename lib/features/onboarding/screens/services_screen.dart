import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  final VoidCallback onNext;
  final int index;

  const ServicesScreen({
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
              padding: const EdgeInsets.all(16), // ⬅️ هامش خفيف بحال Figma
              child: SizedBox.expand(
                child: Image.asset(
                  'assets/images/onboarding_2.png',
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
                    'Services Géolocalisés',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Trouvez rapidement les services et associations près de vous grâce à la géolocalisation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
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
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Passer',
                      style: TextStyle(color: Colors.white70),
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

// 🔹 Curve clipper (موحّدة مع باقي screens)
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
