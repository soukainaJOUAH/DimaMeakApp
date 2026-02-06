import 'package:flutter/material.dart';
import 'services/favorites_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
        animation: FavoritesService.instance,
        builder: (context, _) {
          final favorites = FavoritesService.instance.favoritesAidant;

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'Aucun aidant favori',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final profile = favorites[index];
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
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.person, color: Colors.grey),
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (verifie)
                                const Icon(Icons.verified, color: Colors.blue, size: 18),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(rating.toString()),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: disponible ? Colors.green : Colors.grey,
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
                      onPressed: () {
                        FavoritesService.instance.toggleFavorite(profile);
                      },
                      icon: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
