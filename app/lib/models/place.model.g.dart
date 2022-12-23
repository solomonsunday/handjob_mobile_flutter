// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      streetNumber: json['streetNumber'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      zipCode: json['zipCode'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'streetNumber': instance.streetNumber,
      'street': instance.street,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'lat': instance.lat,
      'lon': instance.lon,
    };
