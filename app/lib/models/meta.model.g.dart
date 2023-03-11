// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      page: json['page'] as int?,
      take: json['take'] as int?,
      itemCount: json['itemCount'] as int?,
      total: json['total'] as int?,
    )..limit = json['limit'] as int?;

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'page': instance.page,
      'take': instance.take,
      'limit': instance.limit,
      'itemCount': instance.itemCount,
      'total': instance.total,
    };
