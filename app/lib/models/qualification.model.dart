import 'package:json_annotation/json_annotation.dart';
import 'package:ui_package/ui_package.dart';

part 'qualification.model.g.dart';

@JsonSerializable()
class Qualification extends HasNameField {
  String? id;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? disabled;
  bool? isSystemDefined;
  @override
  String name;
  String? description;

  Qualification({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.disabled,
    this.isSystemDefined,
    required this.name,
    this.description,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) =>
      _$QualificationFromJson(json);
  Map<String, dynamic> toJson() => _$QualificationToJson(this);
}
