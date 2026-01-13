import 'package:tourist_guide_app/domain/model/sight.dart';

sealed class SightListState {}

class LoadingState extends SightListState {}

class SuccessState extends SightListState {
  final List<Sight> sights;

  SuccessState(this.sights);
}

class EmptyState extends SightListState {}

class ErrorState extends SightListState {
  final String message;

  ErrorState(this.message);
}
