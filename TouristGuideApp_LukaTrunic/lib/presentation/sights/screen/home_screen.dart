import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/presentation/core/style/extensions.dart';
import 'package:tourist_guide_app/presentation/sights/notifier/state/sight_list_state.dart';
import 'package:tourist_guide_app/presentation/sights/screen/location_details_screen.dart';
import 'package:tourist_guide_app/presentation/sights/widget/place_card.dart';

import '../../core/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sightNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Places", style: context.textTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              switch (state) {
              // 🔄 LOADING
                LoadingState() => Expanded(
                  child: Center(
                    child: Lottie.asset(
                      'assets/animations/loading_sights.json',
                      width: 120,
                    ),
                  ),
                ),

              // ✅ SUCCESS
                SuccessState(sights: final listOfSights) => Expanded(
                  child: ListView.separated(
                    itemCount: listOfSights.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (_, index) {
                      final sight = listOfSights[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LocationDetailsScreen(
                                sight: sight,
                              ),
                            ),
                          );
                        },
                        child: PlaceCard(
                          sight: sight,
                        ),
                      );
                    },

                  ),
                ),

              // 📭 EMPTY
                EmptyState() => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no_locations_found.png',
                        height: 220,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "No places found.",
                        style: context.textSubtitle,
                      ),
                    ],
                  ),
                ),

              // ❌ ERROR
                ErrorState(message: final errorMessage) => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/error_image.png',
                        height: 220,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "There was an error.",
                        style: context.textSubtitle,
                      ),
                    ],
                  ),
                ),
              }

            ],
          ),
        ),
      ),
    );
  }
}

