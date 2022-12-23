// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suggestion _$SuggestionFromJson(Map<String, dynamic> json) => Suggestion(
      placeId: json['placeId'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$SuggestionToJson(Suggestion instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'description': instance.description,
    };
