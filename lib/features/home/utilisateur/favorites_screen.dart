import 'package:flutter/material.dart';
import 'services/favorites_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _query = '';
  bool _onlyAvailable = false;
  bool _onlyVerified = false;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1BA9B5);
    const accent = Color(0xFF0E7C7B);
    const deepBlue = Color(0xFF0A3D91);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: FavoritesService.instance,
          builder: (context, _) {
            final favorites = FavoritesService.instance.favoritesAidant;
            final filtered = _applyFilters(favorites);

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [deepBlue, accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.favorite, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Favoris',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${filtered.length} aidants enregistres',
                                style: const TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.black.withOpacity(0.06)),
                          ),
                          child: TextField(
                            onChanged: (value) => setState(() => _query = value.trim()),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search, color: Colors.black45),
                              hintText: 'Rechercher un aidant',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilterChip(
                              label: const Text('Disponible'),
                              selected: _onlyAvailable,
                              selectedColor: primary.withOpacity(0.18),
                              onSelected: (value) => setState(() => _onlyAvailable = value),
                            ),
                            FilterChip(
                              label: const Text('Verifie'),
                              selected: _onlyVerified,
                              selectedColor: primary.withOpacity(0.18),
                              onSelected: (value) => setState(() => _onlyVerified = value),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.favorite_border, color: primary, size: 28),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Aucun aidant favori',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Ajoutez des aidants pour les retrouver ici.',
                            style: TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final profile = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: _FavoriteCard(
                            profile: profile,
                            onToggle: () => FavoritesService.instance.toggleFavorite(profile),
                          ),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> items) {
    final query = _query.toLowerCase();
    final filtered = items.where((profile) {
      final name = (profile['name'] as String? ?? '').toLowerCase();
      final disponible = profile['disponible'] as bool? ?? false;
      final verifie = profile['verifie'] as bool? ?? false;
      if (query.isNotEmpty && !name.contains(query)) return false;
      if (_onlyAvailable && !disponible) return false;
      if (_onlyVerified && !verifie) return false;
      return true;
    }).toList();

    filtered.sort((a, b) {
      final ra = (a['rating'] as num?) ?? 0;
      final rb = (b['rating'] as num?) ?? 0;
      return rb.compareTo(ra);
    });

    return filtered;
  }
}

class _FavoriteCard extends StatelessWidget {
  final Map<String, dynamic> profile;
  final VoidCallback onToggle;

  const _FavoriteCard({
    required this.profile,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final name = profile['name'] as String? ?? '—';
    final rating = profile['rating'] as num? ?? 0;
    final disponible = profile['disponible'] as bool? ?? false;
    final verifie = profile['verifie'] as bool? ?? false;

    return Container(
      padding: const EdgeInsets.all(14),
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
            radius: 24,
            backgroundColor: const Color(0xFFF1F3F8),
            child: const Icon(Icons.person, color: Color(0xFF0A3D91)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (verifie)
                      const Icon(Icons.verified, color: Color(0xFF1BA9B5), size: 18),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(rating.toStringAsFixed(1)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: disponible ? const Color(0xFF2E8B57) : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        disponible ? 'Disponible' : 'Indispo',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onToggle,
            icon: const Icon(Icons.favorite, color: Color(0xFFE53935)),
          ),
        ],
      ),
    );
  }
}
