import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';

final favoritesProvider =
NotifierProvider<FavoritesNotifier, List<Sight>>(
      () => FavoritesNotifier(),
);

class FavoritesNotifier extends Notifier<List<Sight>> {
  late Box _box;

  @override
  List<Sight> build() {
    _init();
    return [];
  }

  Future<void> _init() async {
    _box = await Hive.openBox('favorites');
    _loadFavorites();
  }

  void _loadFavorites() {
    final favorites = _box.values
        .map((e) => Sight.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    state = favorites;
  }

  bool isFavorite(int sightId) {
    return state.any((s) => s.id == sightId);
  }

  Future<void> toggleFavorite(Sight sight) async {
    if (_box.containsKey(sight.id)) {
      await _box.delete(sight.id);
    } else {
      await _box.put(sight.id, sight.toJson());
    }

    _loadFavorites();
  }
}
