import 'package:flutter/material.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../profile/screens/profile_screen.dart';

enum _SearchTab { accompagnant, association }

class NouvelleDemandeScreen extends StatefulWidget {
  const NouvelleDemandeScreen({super.key});

  @override
  State<NouvelleDemandeScreen> createState() => _NouvelleDemandeScreenState();
}

class _NouvelleDemandeScreenState extends State<NouvelleDemandeScreen> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;
  bool _hoveringNotification = false;
  bool _hoveringProfile = false;
  bool _isSearchHovered = false;

  _SearchTab _selectedTab = _SearchTab.accompagnant;
  String _selectedFilter = 'Tous';

  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Nom et Prénom',
      'type': 'Accompagnateur',
      'rating': 4.5,
    },
    {
      'name': 'Nom et Prénom',
      'type': 'Accompagnateur',
      'rating': 4.5,
    },
    {
      'name': 'Nom',
      'type': 'Association',
      'rating': 4.5,
    },
    {
      'name': 'Nom',
      'type': 'Association',
      'rating': 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SearchBar(
              hovered: _isSearchHovered,
              onHover: (value) => setState(() => _isSearchHovered = value),
            ),
            const SizedBox(height: 12),
            _SegmentedTabs(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
            const SizedBox(height: 10),
            _FilterRow(
              selected: _selectedFilter,
              onChanged: (value) => setState(() => _selectedFilter = value),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _selectedTab == _SearchTab.accompagnant
                  ? ListView.separated(
                      itemCount: 2,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return _ListCard(
                          name: item['name'],
                          type: item['type'],
                          rating: item['rating'],
                        );
                      },
                    )
                  : GridView.builder(
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return _GridCard(
                          name: item['name'],
                          type: item['type'],
                          rating: item['rating'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(context),
    );
  }

  PreferredSizeWidget _buildHeader() {
    final primary = const Color(0xFF1BA9B5);

    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringNotification = true),
                  onExit: (_) => setState(() => _hoveringNotification = false),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _hoveringNotification ? primary : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: _hoveringNotification ? primary : Colors.grey.shade300),
                        boxShadow: _hoveringNotification
                            ? [BoxShadow(color: primary.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 3))]
                            : null,
                      ),
                      child: Icon(Icons.notifications_none, color: _hoveringNotification ? Colors.white : primary, size: 22),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringProfile = true),
                  onExit: (_) => setState(() => _hoveringProfile = false),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _hoveringProfile ? primary : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: _hoveringProfile ? primary : Colors.grey.shade300),
                        boxShadow: _hoveringProfile
                            ? [BoxShadow(color: primary.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 3))]
                            : null,
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

  Widget _buildFooter(BuildContext context) {
    final primary = const Color(0xFF1BA9B5);
    final gray = Colors.grey.shade600;

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
                      boxShadow: highlighted
                          ? [BoxShadow(color: primary.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3))]
                          : null,
                    ),
                    child: Icon(icon, size: 24, color: highlighted ? Colors.white : primary),
                  );
                }),
                const SizedBox(height: 6),
                Text(label, style: TextStyle(fontSize: 12, color: active || _hoveredIndex == idx ? primary : gray)),
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
            item(icon: Icons.home, label: 'Accueil', active: _selectedIndex == 0, idx: 0),
            item(icon: Icons.map_outlined, label: 'Maps', active: _selectedIndex == 1, idx: 1),
            item(icon: Icons.favorite_border, label: 'Favoris', active: _selectedIndex == 2, idx: 2),
            item(icon: Icons.settings, label: 'Paramètres', active: _selectedIndex == 3, idx: 3),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final bool hovered;
  final ValueChanged<bool> onHover;

  const _SearchBar({
    required this.hovered,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hovered ? const Color(0xFF0386D0) : Colors.grey.shade300;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6FB),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: hovered
              ? [BoxShadow(color: borderColor.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Accompagne',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final _SearchTab selected;
  final ValueChanged<_SearchTab> onChanged;

  const _SegmentedTabs({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          _Tab(
            label: 'Accompagne',
            selected: selected == _SearchTab.accompagnant,
            onTap: () => onChanged(_SearchTab.accompagnant),
          ),
          _Tab(
            label: 'Association',
            selected: selected == _SearchTab.association,
            onTap: () => onChanged(_SearchTab.association),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.black : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _FilterRow({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['Tous', 'Note', 'Lieu', 'Expérience'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final active = selected == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(f),
                  if (f == 'Lieu' || f == 'Note') const Icon(Icons.expand_more, size: 16),
                ],
              ),
              selected: active,
              onSelected: (_) => onChanged(f),
              selectedColor: const Color(0xFF0E7C7B),
              labelStyle: TextStyle(color: active ? Colors.white : Colors.black87),
              backgroundColor: const Color(0xFFF1F3F8),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final String name;
  final String type;
  final double rating;

  const _ListCard({
    required this.name,
    required this.type,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(type, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.blue, size: 16),
                    const SizedBox(width: 4),
                    Text(rating.toString(), style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.blue, size: 16),
                    SizedBox(width: 4),
                    Text('Expérience', style: TextStyle(fontSize: 12, color: Colors.blue)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _GradientButton(label: 'Details', onTap: () {}),
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final String name;
  final String type;
  final double rating;

  const _GridCard({
    required this.name,
    required this.type,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 88,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(type, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.blue, size: 16),
              const SizedBox(width: 4),
              Text(rating.toString(), style: const TextStyle(fontSize: 12)),
              const Spacer(),
              _GradientButton(label: 'Details', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Details',
          style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
