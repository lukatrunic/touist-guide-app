import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';

final favoritesProvider =
NotifierProvider<FavoritesNotifier, List<Sight>>(
      () => FavoritesNotifier(),
);

class FavoritesNotifier extends Notifier<List<Sight>> {
  static const _storageKey = 'favorite_sights_full';

  @override
  List<Sight> build() {
    _loadFavorites();
    return [];
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_storageKey) ?? [];

    state = stored
        .map((json) => Sight.fromJson(jsonDecode(json)))
        .toList();
  }

  bool isFavorite(int sightId) {
    return state.any((s) => s.id == sightId);
  }

  Future<void> toggleFavorite(Sight sight) async {
    final prefs = await SharedPreferences.getInstance();
    final newState = [...state];

    if (isFavorite(sight.id)) {
      newState.removeWhere((s) => s.id == sight.id);
    } else {
      newState.add(sight);
    }

    state = newState;

    await prefs.setStringList(
      _storageKey,
      newState.map((s) => jsonEncode(s.toJson())).toList(),
    );
  }
}
