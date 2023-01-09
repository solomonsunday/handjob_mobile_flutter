import 'package:handjob_mobile/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'experience.model.g.dart';

@JsonSerializable()
class Experience {
  String? id;
  DateTime? createdBy;
  DateTime? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? disabled;
  bool? isSystemDefined;
  String? accountId;
  String? jobTitle;
  DateTime? startDate;
  DateTime? endDate;
  bool? current;
  String? location;
  String? company;
  String? description;
  String? jobCategoryName;
  String? jobCategoryId;

  Experience({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.disabled,
    this.isSystemDefined,
    this.accountId,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.current,
    this.location,
    this.company,
    this.description,
    this.jobCategoryName,
    this.jobCategoryId,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
