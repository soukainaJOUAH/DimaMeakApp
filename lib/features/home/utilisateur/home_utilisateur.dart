import 'package:flutter/material.dart';
import 'mes_demande_screen.dart';
import 'nouvelle_demande_screen.dart';

class HomeUtilisateur extends StatelessWidget {
  const HomeUtilisateur({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 🔍 Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Recherche',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFFF4F6FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          SizedBox(height: size.height * 0.03),

          // 🟦 Mes demandes (Gradient)
          _HomeCard(
            title: 'Mes demandes',
            icon: Icons.description,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0A3D91),
                Color(0xFF0E7C7B),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(_) =>  MesDemandesScreen(),

                ),
              );
            },
          ),

          SizedBox(height: size.height * 0.02),

          // 🟩 Nouvelle demande (Color موحّد)
        
          _HomeCard(
            title: 'Nouvelle demande',
            icon: Icons.add_circle_outline,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1BA9B5),
                Color(0xFF0E7C7B),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(_) =>  NouvelleDemandeScreen(),

                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//
// 🔹 Card Widget (مشترك)
class _HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final LinearGradient? gradient;
  final Color? color;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.icon,
    this.gradient,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.22,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient, // null فـ Card 2
          color: color,       // null فـ Card 1
        ),
        child: Stack(
          children: [
            // 🔵 Decorative circles
            Positioned(
              top: -40,
              right: -40,
              child: _Circle(size: 140),
            ),
            Positioned(
              top: 30,
              right: 20,
              child: _Circle(size: 80),
            ),

            // 🔹 Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Color(0xFF0A3D91),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔵 Decorative circle
class _Circle extends StatelessWidget {
  final double size;

  const _Circle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.12),
      ),
    );
  }
}