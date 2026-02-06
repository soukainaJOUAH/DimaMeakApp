import 'package:flutter/material.dart';

class OnboardingTemplate extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final int index;
  final String buttonText;
  final bool showSkip;
  final bool showDots;
  final int totalDots;

  const OnboardingTemplate({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onNext,
    required this.onSkip,
    required this.index,
    this.buttonText = 'Suivant',
    this.showSkip = true,
    this.showDots = true,
    this.totalDots = 3,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox.expand(
      child: Column(
        children: [
          // 🔹 Top image section
          Expanded(
            flex: 45,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(size.width * 0.04),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // 🔹 Curved + bottom section
          Expanded(
            flex: 55,
            child: ClipPath(
              clipper: _TopCurveClipper(),
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
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.075,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: size.height * 0.015),

                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: size.width * 0.045,
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    if (showDots)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          totalDots,
                          (dotIndex) => _Dot(isActive: index == dotIndex),
                        ),
                      ),

                    SizedBox(height: size.height * 0.03),

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
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.015),

                    if (showSkip)
                      TextButton(
                        onPressed: onSkip,
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
          ),
        ],
      ),
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
class _TopCurveClipper extends CustomClipper<Path> {
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
