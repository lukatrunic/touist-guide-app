import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tourist_guide_app/domain/model/sight.dart';

part 'sight_rest_client.g.dart';

@RestApi(baseUrl: "http://144.91.87.48:8080/sight")
abstract class SightRestClient {
  factory SightRestClient(Dio dio, {String? baseUrl}) = _SightRestClient;
  
  @GET("/all")
  Future<List<Sight>> getAllSights();
}
