import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final bool openDrawerOnLoad;

  const ProfileScreen({
    super.key,
    this.openDrawerOnLoad = false,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _openedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.openDrawerOnLoad || _openedOnce) return;
    _openedOnce = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.openEndDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0A3D91);
    const accent = Color(0xFF0E7C7B);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFE4EE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black87),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header + avatar
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFDFE4EE),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 88,
                      width: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primary, width: 2),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.person, size: 48, color: Colors.grey),
                    ),
                    Container(
                      height: 26,
                      width: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: accent,
                      ),
                      child: const Icon(Icons.edit, size: 14, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nom',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  'bhrjegrlvdw@gmail.com',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Profile actions
          _SectionCard(
            children: [
              _Tile(
                icon: Icons.edit_document,
                title: 'Modifier les informations du profil',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              _Tile(
                icon: Icons.place_outlined,
                title: 'Gérer l’adresse',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              _Tile(
                icon: Icons.translate,
                title: 'Langue',
                trailing: const Text('Français', style: TextStyle(color: Colors.blue)),
                onTap: () {},
              ),
              _SwitchTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                value: true,
                onChanged: (_) {},
              ),
              _SwitchTile(
                icon: Icons.volume_up_outlined,
                title: 'La lecture vocale',
                value: false,
                onChanged: (_) {},
              ),
              _SwitchTile(
                icon: Icons.mic_none,
                title: 'Micro',
                value: true,
                onChanged: (_) {},
              ),
            ],
          ),

          const SizedBox(height: 12),

          _SectionCard(
            children: [
              _Tile(
                icon: Icons.security,
                title: 'Sécurité',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              _Tile(
                icon: Icons.brightness_6_outlined,
                title: 'Thème',
                trailing: const Text('Mode lumière', style: TextStyle(color: Colors.blue)),
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 12),

          _SectionCard(
            children: [
              _Tile(
                icon: Icons.help_outline,
                title: 'Aide et assistance',
                onTap: () {},
              ),
              _Tile(
                icon: Icons.phone_outlined,
                title: 'Contactez-nous',
                onTap: () {},
              ),
              _Tile(
                icon: Icons.privacy_tip_outlined,
                title: 'Politique de confidentialité',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      endDrawer: Drawer(
        // ...existing code...
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;

  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ...existing code...
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _Tile({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF0E7C7B),
    );
  }
}
