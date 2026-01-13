import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/presentation/sights/widget/place_card.dart';

import '../../../dependency_injection.dart';
import '../../core/style/extensions.dart';
import '../notifier/state/favorites_notifier.dart';
import '../notifier/state/sight_list_state.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);
    final sightsState = ref.watch(sightNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites", style: context.textTitle),
      ),
      body: _buildBody(context, ref, favoriteIds, sightsState),
    );
  }

  Widget _buildBody(
      BuildContext context,
      WidgetRef ref,
      Set<int> favoriteIds,
      SightListState sightsState,
      ) {
    if (favoriteIds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_favorites.png',
              height: 220,
            ),
            const SizedBox(height: 20),
            Text(
              "There are no favorites yet...",
              style: context.textSubtitle,
            ),
          ],
        ),
      );
    }

    if (sightsState is! SuccessState) {
      return const Center(child: CircularProgressIndicator());
    }

    final favorites = sightsState.sights
        .where((s) => favoriteIds.contains(s.id))
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: favorites.length,
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemBuilder: (_, index) => PlaceCard(
        sight: favorites[index],
      ),
    );
  }
}

