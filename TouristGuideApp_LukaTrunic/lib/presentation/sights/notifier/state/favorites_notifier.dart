import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<int>>(
  () => FavoritesNotifier(),
);

class FavoritesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() => {};

  bool isFavorite(int sightId) {
    return state.contains(sightId);
  }

  void toggleFavorite(Sight sight) {
    final newState = Set<int>.from(state);

    if (newState.contains(sight.id)) {
      newState.remove(sight.id);
    } else {
      newState.add(sight.id);
    }

    state = newState;
  }
}
