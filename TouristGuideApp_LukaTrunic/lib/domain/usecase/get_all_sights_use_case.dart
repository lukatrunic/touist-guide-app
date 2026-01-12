import 'package:tourist_guide_app/domain/model/result.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';
import 'package:tourist_guide_app/domain/repository/sight_repository.dart';

class GetAllSightsUseCase {
  final SightRepository _sightRepository;

  GetAllSightsUseCase(this._sightRepository);

  Future<Result<List<Sight>>> call() => _sightRepository.getALlSights();
}