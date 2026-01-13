import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';
import 'package:tourist_guide_app/presentation/sights/screen/location_details_screen.dart';
import '../../core/style/extensions.dart';
import '../notifier/favorites_notifier.dart';

class PlaceCard extends StatelessWidget {
  final Sight sight;

  const PlaceCard({super.key, required this.sight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TAP TO GO TO DETAILS
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LocationDetailsScreen(sight: sight),
          ),
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colorGradientBegin, context.colorGradientEnd],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // MAIN CONTENT
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  // IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      sight.imageUrl,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/placeholder.jpg',
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sight.title,
                          style: context.textSubtitle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          sight.address,
                          style: context.textLabel.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 2),

                        // LAT/LNG
                        Text(
                          "${sight.lat.toStringAsFixed(6)}, "
                          "${sight.lng.toStringAsFixed(6)}",
                          style: context.textLabel.copyWith(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        const Spacer(),

                        // RATING
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < sight.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FAVORITE BUTTON
            Positioned(
              top: 12,
              right: 12,
              child: Consumer(
                builder: (context, ref, _) {
                  final isFav = ref.watch(favoritesProvider).contains(sight.id);

                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(favoritesProvider.notifier)
                          .toggleFavorite(sight);
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 22,
                    ),
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
