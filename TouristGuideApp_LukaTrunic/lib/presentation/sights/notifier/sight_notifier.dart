import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/domain/model/result.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';
import 'package:tourist_guide_app/domain/usecase/get_all_sights_use_case.dart';
import 'package:tourist_guide_app/presentation/sights/notifier/state/sight_list_state.dart';

class SightNotifier extends Notifier<SightListState>{
  late final GetAllSightsUseCase _getAllSightsUseCase;

  @override
  SightListState build() {
    _getAllSightsUseCase = ref.watch(getAllSightsUseCaseProvider);
    getAllSights();
    return LoadingState();
  }

  void getAllSights() async {
    state = LoadingState();

    await Future.delayed(const Duration(seconds: 2));

    final result = await _getAllSightsUseCase();

    switch(result){
      case Ok<List<Sight>>():
        state = result.value.isEmpty ? EmptyState() : SuccessState(result.value);
      case Error():
        state = ErrorState(result.error.toString());
    }
  }
}