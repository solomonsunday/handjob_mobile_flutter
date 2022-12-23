import 'package:json_annotation/json_annotation.dart';

part 'suggestion.model.g.dart';

@JsonSerializable()
class Suggestion {
  final String placeId;
  final String description;

  Suggestion({required this.placeId, required this.description});

  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      _$SuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionToJson(this);
}
