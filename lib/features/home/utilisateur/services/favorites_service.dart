import 'package:flutter/foundation.dart';

class FavoritesService extends ChangeNotifier {
	FavoritesService._();

	static final FavoritesService instance = FavoritesService._();

	final Map<String, Map<String, dynamic>> _favoritesByName = {};

	bool isFavorite(String name) => _favoritesByName.containsKey(name);

	void toggleFavorite(Map<String, dynamic> profile) {
		final name = profile['name'] as String?;
		if (name == null) return;

		if (_favoritesByName.containsKey(name)) {
			_favoritesByName.remove(name);
		} else {
			_favoritesByName[name] = Map<String, dynamic>.from(profile);
		}

		notifyListeners();
	}

	List<Map<String, dynamic>> get favorites => _favoritesByName.values.toList();

	List<Map<String, dynamic>> get favoritesAidant => _favoritesByName.values
			.where((p) => (p['type'] as String?) == 'accompagnant')
			.toList();
}
