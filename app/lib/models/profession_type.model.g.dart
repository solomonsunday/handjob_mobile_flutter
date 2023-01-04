// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profession_type.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfessionType _$ProfessionTypeFromJson(Map<String, dynamic> json) =>
    ProfessionType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      group: json['group'] as String?,
      groupId: json['groupId'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProfessionTypeToJson(ProfessionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'groupId': instance.groupId,
      'description': instance.description,
    };
