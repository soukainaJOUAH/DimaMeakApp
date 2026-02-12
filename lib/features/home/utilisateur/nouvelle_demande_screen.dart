import 'package:flutter/material.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../notifications/services/notifications_service.dart';
import 'favorites_screen.dart';
import 'home_utilisateur.dart';
import 'map_screen.dart';
import 'settings_screen.dart';
import 'widgets/utilisateur_profile_drawer.dart';

enum _SearchTab { accompagnant, association }

class NouvelleDemandeScreen extends StatefulWidget {
  const NouvelleDemandeScreen({super.key});

  @override
  State<NouvelleDemandeScreen> createState() => _NouvelleDemandeScreenState();
}

class _NouvelleDemandeScreenState extends State<NouvelleDemandeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int _hoveredIndex = -1;
  bool _hoveringNotification = false;
  bool _hoveringProfile = false;
  bool _isSearchHovered = false;
  String _searchQuery = '';

  _SearchTab _selectedTab = _SearchTab.accompagnant;
  String _selectedFilter = 'Tous';
  String? _selectedLocation;

  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Nom et Prénom',
      'type': 'Accompagnant',
      'category': 'Accompagnant',
      'rating': 4.5,
      'helped': 22,
      'distance': '1.2 km',
      'location': 'Casablanca',
      'available': true,
      'verified': true,
      'skills': ['Transport', 'Courses', 'Aide medicale'],
    },
    {
      'name': 'Nom et Prénom',
      'type': 'Accompagnant',
      'category': 'Accompagnant',
      'rating': 4.1,
      'helped': 9,
      'distance': '2.8 km',
      'location': 'Mohammedia',
      'available': false,
      'verified': false,
      'skills': ['Accompagnement', 'Lecture vocale'],
    },
    {
      'name': 'Nom',
      'type': 'Association',
      'category': 'Association',
      'rating': 4.7,
      'helped': 48,
      'distance': '3.4 km',
      'location': 'Rabat',
      'available': true,
      'verified': true,
      'skills': ['Soutien social', 'Aides materielles'],
    },
    {
      'name': 'Nom',
      'type': 'Association',
      'category': 'Association',
      'rating': 4.0,
      'helped': 15,
      'distance': '4.1 km',
      'location': 'Salé',
      'available': true,
      'verified': false,
      'skills': ['Reeducation', 'Soutien psychologique'],
    },
    {
      'name': 'Amina El Idrissi',
      'type': 'Accompagnant',
      'category': 'Accompagnant',
      'rating': 4.8,
      'helped': 35,
      'distance': '0.6 km',
      'location': 'Casablanca',
      'available': true,
      'verified': true,
      'skills': ['Courses', 'Accompagnement'],
    },
    {
      'name': 'Youssef Benali',
      'type': 'Accompagnant',
      'category': 'Accompagnant',
      'rating': 4.3,
      'helped': 14,
      'distance': '1.9 km',
      'location': 'Rabat',
      'available': true,
      'verified': false,
      'skills': ['Transport', 'Aide medicale'],
    },
    {
      'name': 'Sara Ouahbi',
      'type': 'Accompagnant',
      'category': 'Accompagnant',
      'rating': 4.0,
      'helped': 6,
      'distance': '3.2 km',
      'location': 'Marrakesh',
      'available': false,
      'verified': true,
      'skills': ['Lecture vocale', 'Soutien moral'],
    },
    {
      'name': 'Association Nour',
      'type': 'Association',
      'category': 'Association',
      'rating': 4.6,
      'helped': 52,
      'distance': '2.1 km',
      'location': 'Fes',
      'available': true,
      'verified': true,
      'skills': ['Soutien social', 'Aides materielles'],
    },
    {
      'name': 'Association Amal',
      'type': 'Association',
      'category': 'Association',
      'rating': 4.2,
      'helped': 19,
      'distance': '5.0 km',
      'location': 'Agadir',
      'available': true,
      'verified': false,
      'skills': ['Reeducation', 'Aide medicale'],
    },
    {
      'name': 'Association Hayat',
      'type': 'Association',
      'category': 'Association',
      'rating': 4.9,
      'helped': 61,
      'distance': '0.9 km',
      'location': 'Tangier',
      'available': true,
      'verified': true,
      'skills': ['Soutien psychologique', 'Transport'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildHeader(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(),
      ),
      endDrawer: const UtilisateurProfileDrawer(),
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
                    child: AnimatedBuilder(
                      animation: NotificationsService.instance,
                      builder: (context, _) {
                        final unread = NotificationsService.instance.unreadCount;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
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
                            if (unread > 0)
                              const Positioned(
                                right: -2,
                                top: -2,
                                child: _NotifBadge(),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringProfile = true),
                  onExit: (_) => setState(() => _hoveringProfile = false),
                  child: GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
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
          onTap: () {
            if (idx == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeUtilisateur()),
              );
              return;
            }
            setState(() => _selectedIndex = idx);
          },
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

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return const MapScreen();
      case 2:
        return const FavoritesScreen();
      case 3:
        return const SettingsScreen();
      case 0:
      default:
        final results = _filteredItems();
        return Column(
          children: [
            _SearchBar(
              hovered: _isSearchHovered,
              onHover: (value) => setState(() => _isSearchHovered = value),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 12),
            _SegmentedTabs(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
            const SizedBox(height: 10),
            _FilterRow(
              selected: _selectedFilter,
              selectedLocation: _selectedLocation,
              onChanged: _handleFilterChange,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _selectedTab == _SearchTab.accompagnant
                  ? ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = results[index];
                        return _ListCard(
                          name: item['name'],
                          type: item['type'],
                          rating: item['rating'],
                          distance: item['distance'],
                          location: item['location'],
                          available: item['available'],
                          verified: item['verified'],
                          skills: List<String>.from(item['skills'] as List),
                          onRequest: () => _handleRequest(item),
                          onMessage: () => _handleMessage(item),
                        );
                      },
                    )
                  : GridView.builder(
                      itemCount: results.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final item = results[index];
                        return _GridCard(
                          name: item['name'],
                          type: item['type'],
                          rating: item['rating'],
                          distance: item['distance'],
                          location: item['location'],
                          available: item['available'],
                          verified: item['verified'],
                          onRequest: () => _handleRequest(item),
                          onMessage: () => _handleMessage(item),
                        );
                      },
                    ),
            ),
          ],
        );
    }
  }

  List<Map<String, dynamic>> _filteredItems() {
    final query = _searchQuery.trim().toLowerCase();
    final filtered = _items.where((item) {
      final category = item['category'] as String? ?? '';
      if (_selectedTab == _SearchTab.accompagnant && category != 'Accompagnant') return false;
      if (_selectedTab == _SearchTab.association && category != 'Association') return false;

      if (query.isNotEmpty) {
        final name = (item['name'] as String? ?? '').toLowerCase();
        final location = (item['location'] as String? ?? '').toLowerCase();
        final skills = (item['skills'] as List?)?.cast<String>().map((s) => s.toLowerCase()).toList() ?? <String>[];
        final match = name.contains(query) || location.contains(query) || skills.any((s) => s.contains(query));
        if (!match) return false;
      }

      if (_selectedFilter == 'Lieu' && _selectedLocation != null) {
        final location = item['location'] as String? ?? '';
        if (location != _selectedLocation) return false;
      }

      if (_selectedFilter == 'Experience') {
        final helped = (item['helped'] as num?)?.toInt() ?? 0;
        if (helped <= 0) return false;
      }

      return true;
    }).toList();

    if (_selectedFilter == 'Note') {
      filtered.sort((a, b) {
        final ra = (a['rating'] as num?)?.toDouble() ?? 0;
        final rb = (b['rating'] as num?)?.toDouble() ?? 0;
        return rb.compareTo(ra);
      });
    }

    if (_selectedFilter == 'Experience') {
      filtered.sort((a, b) {
        final ha = (a['helped'] as num?)?.toInt() ?? 0;
        final hb = (b['helped'] as num?)?.toInt() ?? 0;
        return hb.compareTo(ha);
      });
    }

    return filtered;
  }

  void _handleFilterChange(String value) {
    if (value == 'Lieu') {
      _pickLocation();
      return;
    }

    setState(() {
      _selectedFilter = value;
      if (value != 'Lieu') {
        _selectedLocation = null;
      }
    });
  }

  Future<void> _pickLocation() async {
    final locations = _items.map((e) => e['location'] as String? ?? '').where((e) => e.isNotEmpty).toSet().toList()..sort();
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Choisir un lieu'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(''),
              child: const Text('Toutes les villes'),
            ),
            for (final loc in locations)
              SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(loc),
                child: Text(loc),
              ),
          ],
        );
      },
    );

    if (!mounted) return;
    setState(() {
      _selectedFilter = 'Lieu';
      _selectedLocation = result?.isEmpty ?? true ? null : result;
    });
  }

  void _handleRequest(Map<String, dynamic> item) {
    final name = item['name'] as String? ?? '';
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Envoyer une demande'),
          content: Text('Voulez-vous envoyer une demande a $name ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Demande envoyee.')),
                );
              },
              child: const Text('Envoyer'),
            ),
          ],
        );
      },
    );
  }

  void _handleMessage(Map<String, dynamic> item) {
    final name = item['name'] as String? ?? '';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ouverture du chat avec $name...')),
    );
  }
}

class _NotifBadge extends StatelessWidget {
  const _NotifBadge();

  @override
  Widget build(BuildContext context) {
    final count = NotificationsService.instance.unreadCount;
    final text = count > 99 ? '99+' : count.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final bool hovered;
  final ValueChanged<bool> onHover;
  final ValueChanged<String> onChanged;

  const _SearchBar({
    required this.hovered,
    required this.onHover,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hovered ? const Color(0xFFB7C7D9) : const Color(0xFFD6DFEA);

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F6FB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: hovered
              ? [BoxShadow(color: borderColor.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black54, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: TextField(
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  hintText: 'Rechercher un aidant ou association',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: onChanged,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.black54, size: 18),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD6DFEA)),
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
            borderRadius: BorderRadius.circular(16),
            border: selected ? Border.all(color: const Color(0xFFB7C7D9)) : null,
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
  final String? selectedLocation;
  final ValueChanged<String> onChanged;

  const _FilterRow({
    required this.selected,
    required this.selectedLocation,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['Tous', 'Note', 'Lieu', 'Experience'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final active = selected == f;
          final label = f == 'Lieu' && selectedLocation != null ? 'Lieu: $selectedLocation' : f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label),
                  if (f == 'Lieu' || f == 'Note') const Icon(Icons.expand_more, size: 16),
                ],
              ),
              selected: active,
              onSelected: (_) => onChanged(f),
              selectedColor: const Color(0xFF0E7C7B),
              labelStyle: TextStyle(color: active ? Colors.white : Colors.black87, fontWeight: FontWeight.w600),
              backgroundColor: const Color(0xFFF1F3F8),
              shape: StadiumBorder(
                side: BorderSide(color: active ? const Color(0xFF0E7C7B) : const Color(0xFFD6DFEA)),
              ),
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
  final String distance;
  final String location;
  final bool available;
  final bool verified;
  final List<String> skills;
  final VoidCallback onRequest;
  final VoidCallback onMessage;

  const _ListCard({
    required this.name,
    required this.type,
    required this.rating,
    required this.distance,
    required this.location,
    required this.available,
    required this.verified,
    required this.skills,
    required this.onRequest,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFE7F1FF),
            child: const Icon(Icons.person, color: Color(0xFF2B6DEB)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    if (verified) const Icon(Icons.verified, color: Color(0xFF1BA9B5), size: 18),
                  ],
                ),
                const SizedBox(height: 2),
                Text(type, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: available ? const Color(0xFF2E8B57) : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        available ? 'Disponible' : 'Indispo',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.place, color: Colors.black45, size: 14),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(width: 10),
                    const Icon(Icons.near_me, color: Colors.black45, size: 14),
                    const SizedBox(width: 4),
                    Text(distance, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: skills
                      .take(2)
                      .map(
                        (skill) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(skill, style: const TextStyle(fontSize: 11)),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              _GradientButton(label: 'Demander', onTap: onRequest),
              const SizedBox(height: 8),
              _OutlineButton(label: 'Message', onTap: onMessage),
            ],
          ),
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final String name;
  final String type;
  final double rating;
  final String distance;
  final String location;
  final bool available;
  final bool verified;
  final VoidCallback onRequest;
  final VoidCallback onMessage;

  const _GridCard({
    required this.name,
    required this.type,
    required this.rating,
    required this.distance,
    required this.location,
    required this.available,
    required this.verified,
    required this.onRequest,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 88,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.storefront, color: const Color(0xFF7B5FD6), size: 30),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600))),
              if (verified) const Icon(Icons.verified, color: Color(0xFF1BA9B5), size: 16),
            ],
          ),
          const SizedBox(height: 2),
          Text(type, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: available ? const Color(0xFF2E8B57) : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  available ? 'Disponible' : 'Indispo',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.place, color: Colors.black45, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(location, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ),
            ],
          ),
          const Spacer(),
          _GradientButton(label: 'Demander', onTap: onRequest),
          const SizedBox(height: 6),
          _OutlineButton(label: 'Message', onTap: onMessage),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF1BA9B5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF1BA9B5), fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
