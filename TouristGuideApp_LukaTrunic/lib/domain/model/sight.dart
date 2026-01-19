import 'package:json_annotation/json_annotation.dart';

part 'sight.g.dart';

@JsonSerializable()
class Sight {
  final int id;
  final String title;
  final String description;
  final String address;
  final double lat;
  final double lng;
  final int rating;
  final String imageUrl;

  Sight({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.imageUrl,
  });

  factory Sight.fromJson(Map<String, dynamic> json) =>
      _$SightFromJson(json);

  Map<String, dynamic> toJson() => _$SightToJson(this);
}
