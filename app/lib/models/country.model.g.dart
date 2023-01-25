// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      capital: json['capital'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'capital': instance.capital,
    };
