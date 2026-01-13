import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';
import 'package:tourist_guide_app/presentation/core/style/extensions.dart';
import 'package:tourist_guide_app/presentation/core/widget/custom_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notifier/state/favorites_notifier.dart';

class LocationDetailsScreen extends ConsumerWidget {
  final Sight sight;

  const LocationDetailsScreen({
    super.key,
    required this.sight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(favoritesProvider).contains(sight.id);

    return Scaffold(
      body: Stack(
        children: [
          // 🖼️ TOP IMAGE
          Image.network(
            sight.imageUrl,
            height: 320,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // 🔙 BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: _circleIcon(
                  context,
                  Icons.arrow_back,
                      () => Navigator.pop(context),
                  backgroundColor: Colors.white,
                  iconColor: context.colorGradientEnd,
                ),
              ),
            ),
          ),

          // 📄 DRAGGABLE CONTENT
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.colorBackground,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.only(bottom: 120),
                  children: [
                    Text(
                      sight.title,
                      style: context.textTitle,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      sight.address,
                      style: context.textSubtitle,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Rating",
                      style: context.textSubtitle,
                    ),
                    const SizedBox(height: 6),

                    _ratingStars(context, sight.rating),

                    const SizedBox(height: 20),

                    Text(
                      sight.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              );
            },
          ),

          // ❤️ FAVORITE BUTTON (FIGMA POSITION)
          Positioned(
            top: 290,
            right: 40,
            child: _circleIcon(
              context,
              isFav ? Icons.favorite : Icons.favorite_border,
                  () {
                ref.read(favoritesProvider.notifier).toggleFavorite(sight);
              },
              backgroundColor: context.colorGradientEnd,
              iconColor: Colors.white,
            ),

          ),

          // 🔘 FIXED BOTTOM BUTTON
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SafeArea(
              child: CustomActionButton(
                text: "Show on maps",
                onPressed: () => openInMaps(
                  sight.lat,
                  sight.lng,
                  sight.title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 CIRCLE ICON (FIGMA STYLE)
  Widget _circleIcon(
      BuildContext context,
      IconData icon,
      VoidCallback onTap, {
        required Color backgroundColor,
        required Color iconColor,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
      ),
    );
  }


  // ⭐ RATING STARS
  Widget _ratingStars(BuildContext context, int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: context.colorGradientEnd,
          size: 22,
        );
      }),
    );
  }

  // 🗺️ OPEN IN MAPS
  void openInMaps(double latitude, double longitude, String label) async {
    try {
      final Uri url = Platform.isIOS
          ? Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude')
          : Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude($label)');

      await launchUrl(url);
    } catch (e) {
      debugPrint("Error opening maps: $e");
    }
  }
}
