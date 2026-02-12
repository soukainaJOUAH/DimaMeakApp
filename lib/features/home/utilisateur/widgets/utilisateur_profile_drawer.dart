import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../settings_screen.dart';

class UtilisateurProfileDrawer extends StatelessWidget {
  const UtilisateurProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: user == null
              ? _buildProfile(
                  context,
                  _demoProfileData(),
                  'demo@dima-m3ak.app',
                  isDemo: true,
                )
              : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoadingState(context);
                    }

                    final data = snapshot.data?.data() ?? <String, dynamic>{};
                    return _buildProfile(context, data, user.email);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildProfile(
    BuildContext context,
    Map<String, dynamic> data,
    String? email, {
    bool isDemo = false,
  }) {
    final primary = const Color(0xFF1BA9B5);
    final accent = const Color(0xFF0E7C7B);
    final deepBlue = const Color(0xFF0A3D91);
    const mint = Color(0xFFE6F6EF);
    const mintIcon = Color(0xFF2E8B57);
    const lavender = Color(0xFFF3E9FF);
    const lavenderIcon = Color(0xFF7B5FD6);
    const teal = Color(0xFFE4F7F6);
    const tealIcon = Color(0xFF1BA9B5);
    const sky = Color(0xFFE7F1FF);
    const skyIcon = Color(0xFF2B6DEB);
    const amberBg = Color(0xFFFFF1D6);
    const amberIcon = Color(0xFFB26A00);
    const coralBg = Color(0xFFFFE7E7);
    const coralIcon = Color(0xFFE53935);

    final name = _stringOrFallback(data['name']);
    final dob = _stringOrFallback(data['dob']);
    final phone = _stringOrFallback(data['phone']);
    final location = _stringOrFallback(data['location']);
    final emergencyName = _stringOrFallback(data['emergencyName']);
    final emergencyPhone = _stringOrFallback(data['emergencyPhone']);
    final handicaps = _listOrEmpty(data['handicaps']);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: lavender,
                        border: Border.all(color: lavenderIcon.withOpacity(0.25)),
                      ),
                      child: Icon(Icons.person, color: lavenderIcon, size: 36),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(email ?? '-', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                          if (isDemo) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary.withOpacity(0.2)),
                              ),
                              child: Text(
                                'Mode demo',
                                style: TextStyle(color: primary, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => _openSettings(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(Icons.edit, size: 16, color: accent),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionHeader(title: 'Informations personnelles'),
              _GroupedCard(
                children: [
                  _InfoTile(
                    label: 'Date de naissance',
                    value: dob,
                    icon: Icons.cake_outlined,
                    iconBackground: amberBg,
                    iconColor: amberIcon,
                  ),
                  _InfoTile(
                    label: 'Telephone',
                    value: phone,
                    icon: Icons.phone_outlined,
                    iconBackground: sky,
                    iconColor: skyIcon,
                  ),
                  _InfoTile(
                    label: 'Adresse',
                    value: location,
                    icon: Icons.place_outlined,
                    iconBackground: teal,
                    iconColor: tealIcon,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SectionHeader(title: 'Situation de handicap'),
              _GroupedCard(
                children: [
                  if (handicaps.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text('Non renseigne', style: TextStyle(color: Colors.black54)),
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: handicaps
                          .map(
                            (h) => Chip(
                              label: Text(h),
                              backgroundColor: const Color(0xFFF1F3F8),
                              labelStyle: TextStyle(color: primary, fontWeight: FontWeight.w600),
                              shape: StadiumBorder(side: BorderSide(color: primary.withOpacity(0.25))),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              _SectionHeader(title: 'Contact urgence'),
              _GroupedCard(
                children: [
                  _InfoTile(
                    label: 'Nom',
                    value: emergencyName,
                    icon: Icons.person_outline,
                    iconBackground: mint,
                    iconColor: mintIcon,
                  ),
                  _InfoTile(
                    label: 'Telephone',
                    value: emergencyPhone,
                    icon: Icons.phone_in_talk_outlined,
                    iconBackground: coralBg,
                    iconColor: coralIcon,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Image.asset(
            'assets/images/drawer2.png',
            height: 190,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  String _stringOrFallback(dynamic value) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? 'Non renseigne' : text;
  }

  List<String> _listOrEmpty(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).where((e) => e.trim().isNotEmpty).toList();
    }
    return [];
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  Map<String, dynamic> _demoProfileData() {
    return {
      'name': 'Demo Utilisateur',
      'dob': '01/01/1990',
      'phone': '+212 6 00 00 00 00',
      'location': 'Casablanca',
      'emergencyName': 'Contact Demo',
      'emergencyPhone': '+212 6 11 11 11 11',
      'handicaps': ['Mobilite', 'Visuel'],
    };
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}

class _GroupedCard extends StatelessWidget {
  final List<Widget> children;

  const _GroupedCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const Divider(height: 12),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    this.iconBackground = const Color(0xFFF1F3F8),
    this.iconColor = const Color(0xFF0A3D91),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ),
          Expanded(
            flex: 6,
            child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
