import 'package:json_annotation/json_annotation.dart';

part 'profession_type.model.g.dart';

@JsonSerializable()
class ProfessionType {
  int? id;
  String? name;
  String? group;
  int? groupId;
  String? description;

  ProfessionType({
    this.id,
    this.name,
    this.group,
    this.groupId,
    this.description,
  });

  factory ProfessionType.fromJson(Map<String, dynamic> json) =>
      _$ProfessionTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProfessionTypeToJson(this);
}
