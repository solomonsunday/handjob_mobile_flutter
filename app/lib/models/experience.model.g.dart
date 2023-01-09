// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      id: json['id'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : DateTime.parse(json['createdBy'] as String),
      updatedBy: json['updatedBy'] == null
          ? null
          : DateTime.parse(json['updatedBy'] as String),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      disabled: json['disabled'] as bool?,
      isSystemDefined: json['isSystemDefined'] as bool?,
      accountId: json['accountId'] as String?,
      jobTitle: json['jobTitle'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      current: json['current'] as bool?,
      location: json['location'] as String?,
      company: json['company'] as String?,
      description: json['description'] as String?,
      jobCategoryName: json['jobCategoryName'] as String?,
      jobCategoryId: json['jobCategoryId'] as String?,
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy?.toIso8601String(),
      'updatedBy': instance.updatedBy?.toIso8601String(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDeleted': instance.isDeleted,
      'disabled': instance.disabled,
      'isSystemDefined': instance.isSystemDefined,
      'accountId': instance.accountId,
      'jobTitle': instance.jobTitle,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'current': instance.current,
      'location': instance.location,
      'company': instance.company,
      'description': instance.description,
      'jobCategoryName': instance.jobCategoryName,
      'jobCategoryId': instance.jobCategoryId,
    };
