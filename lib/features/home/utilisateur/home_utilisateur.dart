import 'package:flutter/material.dart';
import 'mes_demande_screen.dart';
import 'search/search_screen.dart';
import 'map_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'nouvelle_demande_screen.dart';

// Replace Stateless HomeUtilisateur with Stateful implementation
class HomeUtilisateur extends StatefulWidget {
  const HomeUtilisateur({super.key});

  @override
  State<HomeUtilisateur> createState() => _HomeUtilisateurState();
}

class _HomeUtilisateurState extends State<HomeUtilisateur> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;
  bool _hoveringNotification = false;
  bool _hoveringProfile = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildHeader(context, _selectedIndex),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildBody(size),
      ),
      // call the footer method that lives on this State (so it can call setState and access _hoveredIndex)
      bottomNavigationBar: _buildFooter(context, _selectedIndex),
    );
  }

  Widget _buildBody(Size size) {
    // index-based content to avoid pushing new Scaffolds (no duplicate bars)
    switch (_selectedIndex) {
      case 1:
        return const MapScreen();
      case 2:
        return const FavoritesScreen();
      case 3:
        return const SettingsScreen();
      case 0:
      default:
        return Column(
          children: [
            SizedBox(height: size.height * 0.02),

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
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MesDemandesScreen()));
              },
            ),

            SizedBox(height: size.height * 0.02),

            // 🟩 Nouvelle demande navigue vers Search (maintenu)
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
                  MaterialPageRoute(builder: (_) => const NouvelleDemandeScreen()),
                );
              },
            ),
          ],
        );
    }
  }

  // -----------------------
  // Header (top) design - matches footer style
  // -----------------------
  PreferredSizeWidget _buildHeader(BuildContext context, int currentIndex) {
    final primary = const Color(0xFF1BA9B5);
    final gray = Colors.grey.shade600;

    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // notification on the left (navigates to Notifications)
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringNotification = true),
                  onExit: (_) => setState(() => _hoveringNotification = false),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _hoveringNotification ? primary : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: _hoveringNotification ? primary : Colors.grey.shade300),
                        boxShadow: _hoveringNotification ? [BoxShadow(color: primary.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 3))] : null,
                      ),
                      child: Icon(Icons.notifications_none, color: _hoveringNotification ? Colors.white : primary, size: 22),
                    ),
                  ),
                ),

                // profile on the right (navigates to ProfileScreen)
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringProfile = true),
                  onExit: (_) => setState(() => _hoveringProfile = false),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _hoveringProfile ? primary : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: _hoveringProfile ? primary : Colors.grey.shade300),
                        boxShadow: _hoveringProfile ? [BoxShadow(color: primary.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 3))] : null,
                      ),
                      child: Icon(Icons.person, color: _hoveringProfile ? Colors.white : primary, size: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Footer is now an instance method so it can use setState and _hoveredIndex
  Widget _buildFooter(BuildContext context, int currentIndex) {
    final primary = const Color(0xFF1BA9B5);
    final gray = Colors.grey.shade600;
    final fontFamily = Theme.of(context).textTheme.bodyMedium?.fontFamily;

    Widget item({required IconData icon, required String label, required bool active, required int idx}) {
      return Expanded(
        child: InkWell(
          onTap: () => setState(() => _selectedIndex = idx),
          onHover: (hover) => setState(() => _hoveredIndex = hover ? idx : -1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (_) {
                  final highlighted = active || _hoveredIndex == idx;
                  return Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: highlighted ? primary : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: highlighted ? primary : Colors.grey.shade300),
                      boxShadow: highlighted ? [BoxShadow(color: primary.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3))] : null,
                    ),
                    child: Icon(icon, size: 24, color: highlighted ? Colors.white : primary),
                  );
                }),
                const SizedBox(height: 6),
                Text(label, style: TextStyle(fontSize: 12, fontFamily: fontFamily, color: currentIndex == idx || _hoveredIndex == idx ? primary : gray)),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
      child: SafeArea(
        child: Row(
          children: [
            item(icon: Icons.home, label: 'Accueil', active: currentIndex == 0, idx: 0),
            item(icon: Icons.map_outlined, label: 'Maps', active: currentIndex == 1, idx: 1),
            item(icon: Icons.favorite_border, label: 'Favoris', active: currentIndex == 2, idx: 2),
            item(icon: Icons.settings, label: 'Paramètres', active: currentIndex == 3, idx: 3),
          ],
        ),
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