import 'package:json_annotation/json_annotation.dart';

part 'state.model.g.dart';

@JsonSerializable()
class State {
  int? id;
  String? code;
  String? name;
  int? countryId;

  State({
    this.id,
    this.code,
    this.name,
    this.countryId,
  });

  factory State.fromJson(Map<String, dynamic> json) => _$StateFromJson(json);
  Map<String, dynamic> toJson() => _$StateToJson(this);
}
