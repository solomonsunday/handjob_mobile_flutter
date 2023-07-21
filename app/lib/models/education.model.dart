import 'package:json_annotation/json_annotation.dart';

part 'education.model.g.dart';

@JsonSerializable()
class Education {
  String? id;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? disabled;
  bool? isSystemDefined;
  String? accountId;
  String? institution;
  String? qualification;
  String? course;
  DateTime? yearOfGraduation;
  String? address;
  String? city;
  String? country;

  Education({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.disabled,
    this.isSystemDefined,
    this.accountId,
    this.institution,
    this.qualification,
    this.course,
    this.yearOfGraduation,
    this.address,
    this.city,
    this.country,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
  Map<String, dynamic> toJson() => _$EducationToJson(this);
}
