import 'package:json_annotation/json_annotation.dart';

part 'state.model.g.dart';

@JsonSerializable()
class CustomState {
  int? id;
  String? code;
  String? name;
  int? countryId;

  CustomState({
    this.id,
    this.code,
    this.name,
    this.countryId,
  });

  factory CustomState.fromJson(Map<String, dynamic> json) =>
      _$CustomStateFromJson(json);
  Map<String, dynamic> toJson() => _$CustomStateToJson(this);
}
