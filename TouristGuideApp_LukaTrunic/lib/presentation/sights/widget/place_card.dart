import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';
import 'package:tourist_guide_app/presentation/sights/screen/location_details_screen.dart';
import '../../core/style/extensions.dart';
import '../notifier/favorites_notifier.dart';

class PlaceCard extends StatelessWidget {
  final Sight sight;

  const PlaceCard({
    super.key,
    required this.sight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ✅ CARD TAP → GO TO DETAILS
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LocationDetailsScreen(sight: sight),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorGradientBegin,
              context.colorGradientEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // 📷 IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                sight.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/placeholder.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 📄 INFO
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

                  const Spacer(),

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

            // ❤️ FAVORITE BUTTON
            Consumer(
              builder: (context, ref, _) {
                final isFav =
                ref.watch(favoritesProvider).contains(sight.id);

                return GestureDetector(
                  // ❤️ ONLY THIS TOGGLES FAVORITE
                  onTap: () {
                    ref
                        .read(favoritesProvider.notifier)
                        .toggleFavorite(sight);
                  },
                  child: Icon(
                    isFav
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white, // always white (Figma)
                    size: 22,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
