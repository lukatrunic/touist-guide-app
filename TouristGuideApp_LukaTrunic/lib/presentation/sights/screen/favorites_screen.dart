import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/presentation/sights/widget/place_card.dart';

import '../../../domain/model/sight.dart';
import '../../core/style/extensions.dart';
import '../notifier/favorites_notifier.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Favorites", style: context.textTitle)),
      body: _buildBody(context, favorites),
    );
  }

  Widget _buildBody(BuildContext context, List<Sight> favorites) {
    if (favorites.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty_favorites.png', height: 220),
              const SizedBox(height: 24),
              Text(
                "There are no favorites yet...",
                style: context.textSubtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Here you will see all your favorite sights. Mark them as favorite by pressing the heart icon.",
                textAlign: TextAlign.center,
                style: context.textBelow,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: favorites.length,
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemBuilder: (_, index) => PlaceCard(sight: favorites[index]),
    );
  }
}
