import 'package:flutter/material.dart';

enum SearchTab { accompagnant, association }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchTab _selectedTab = SearchTab.accompagnant;
  String _selectedFilter = 'Tous';

  final List<Map<String, dynamic>> _profiles = [
    {
      'name': 'Samira Dmiras',
      'type': 'accompagnant',
      'rating': 4.5,
      'disponible': true,
      'verifie': true,
      'favorite': false,
    },
    {
      'name': 'Karim Naji',
      'type': 'accompagnant',
      'rating': 4.5,
      'disponible': false,
      'verifie': true,
      'favorite': false,
    },
    {
      'name': 'Association Rahma',
      'type': 'association',
      'rating': 4.7,
      'disponible': true,
      'verifie': true,
      'favorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final filteredProfiles = _profiles.where((p) {
      if (_selectedTab == SearchTab.accompagnant &&
          p['type'] != 'accompagnant') return false;
      if (_selectedTab == SearchTab.association &&
          p['type'] != 'association') return false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// 🔍 Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Rechercher un aidant ou une association',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {
                      // 🎤 Voice search – Phase 3
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// 🔄 Tabs
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _TabButton(
                    label: 'Accompagnant',
                    selected: _selectedTab == SearchTab.accompagnant,
                    onTap: () {
                      setState(() {
                        _selectedTab = SearchTab.accompagnant;
                      });
                    },
                  ),
                  _TabButton(
                    label: 'Association',
                    selected: _selectedTab == SearchTab.association,
                    onTap: () {
                      setState(() {
                        _selectedTab = SearchTab.association;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🎛️ Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Tous', 'Lieu', 'Association', 'Note']
                    .map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(f),
                          selected: _selectedFilter == f,
                          onSelected: (_) {
                            setState(() {
                              _selectedFilter = f;
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            /// 🪪 Profiles grid
            Expanded(
              child: GridView.builder(
                itemCount: filteredProfiles.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final profile = filteredProfiles[index];
                  return _ProfileCard(
                    name: profile['name'],
                    rating: profile['rating'],
                    disponible: profile['disponible'],
                    verifie: profile['verifie'],
                    favorite: profile['favorite'],
                    onFavoriteToggle: () {
                      setState(() {
                        profile['favorite'] = !profile['favorite'];
                      });
                    },
                    onDetails: () {
                      // ➡️ Navigation to details screen (later)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Tab Button
class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
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
            borderRadius: BorderRadius.circular(25),
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

/// 🪪 Profile Card
class _ProfileCard extends StatelessWidget {
  final String name;
  final double rating;
  final bool disponible;
  final bool verifie;
  final bool favorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onDetails;

  const _ProfileCard({
    required this.name,
    required this.rating,
    required this.disponible,
    required this.verifie,
    required this.favorite,
    required this.onFavoriteToggle,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image + badges
          Stack(
            children: [
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, size: 50),
              ),

              /// Disponible
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: disponible ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    disponible ? 'Disponible' : 'Indispo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

              /// Vérifié
              if (verifie)
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(Icons.verified, color: Colors.blue, size: 18),
                ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(rating.toString()),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                  color: favorite ? Colors.red : Colors.grey,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onDetails,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  backgroundColor: const Color(0xFF0A3D91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}