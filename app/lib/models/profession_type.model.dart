import 'package:json_annotation/json_annotation.dart';
import 'package:ui_package/ui_package.dart';

part 'profession_type.model.g.dart';

@JsonSerializable()
class ProfessionType extends HasNameField {
  int? id;

  @JsonKey(name: "name")
  String name;

  String? group;
  int? groupId;
  String? description;

  ProfessionType({
    this.id,
    required this.name,
    this.group,
    this.groupId,
    this.description,
  });

  factory ProfessionType.fromJson(Map<String, dynamic> json) =>
      _$ProfessionTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProfessionTypeToJson(this);
}
