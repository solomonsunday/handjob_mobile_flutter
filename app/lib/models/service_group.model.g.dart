// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_group.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceGroup _$ServiceGroupFromJson(Map<String, dynamic> json) => ServiceGroup(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ServiceGroupToJson(ServiceGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
