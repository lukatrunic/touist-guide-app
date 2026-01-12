import 'package:tourist_guide_app/domain/model/result.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';

abstract interface class SightRepository {
  Future<Result<List<Sight>>> getALlSights();
}