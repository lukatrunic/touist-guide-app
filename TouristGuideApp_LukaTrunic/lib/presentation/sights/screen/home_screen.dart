import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/presentation/core/style/extensions.dart';
import 'package:tourist_guide_app/presentation/sights/notifier/state/sight_list_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =  ref.watch(sightNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Home Screen', style: context.textSubtitle),
              switch (state){
                LoadingState() => Expanded(child: Center(child: CircularProgressIndicator(color: context.colorText))),
                SuccessState(sights: final listOfSights) => Expanded(
                  child: ListView.separated(
                      itemCount: listOfSights.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) => Text(listOfSights[index].title),
                  ),
                ),
                EmptyState() => Expanded(child: Center(child: Text("Empty..."))),
                ErrorState(message: String errorMessage) => Expanded(child: Center(child: Text(errorMessage))),
              }
            ],
          ),
        ),
      )
    );
  }
}
