// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sight _$SightFromJson(Map<String, dynamic> json) => Sight(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  rating: (json['rating'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$SightToJson(Sight instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'address': instance.address,
  'lat': instance.lat,
  'lng': instance.lng,
  'rating': instance.rating,
  'imageUrl': instance.imageUrl,
};
