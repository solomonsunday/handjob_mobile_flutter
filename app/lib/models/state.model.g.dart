// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

State _$StateFromJson(Map<String, dynamic> json) => State(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      countryId: json['countryId'] as int?,
    );

Map<String, dynamic> _$StateToJson(State instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'countryId': instance.countryId,
    };
