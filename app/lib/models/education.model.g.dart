// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      disabled: json['disabled'] as bool?,
      isSystemDefined: json['isSystemDefined'] as bool?,
      accountId: json['accountId'] as String?,
      institution: json['institution'] as String?,
      qualification: json['qualification'] as String?,
      course: json['course'] as String?,
      yearOfGraduation: json['yearOfGraduation'] == null
          ? null
          : DateTime.parse(json['yearOfGraduation'] as String),
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDeleted': instance.isDeleted,
      'disabled': instance.disabled,
      'isSystemDefined': instance.isSystemDefined,
      'accountId': instance.accountId,
      'institution': instance.institution,
      'qualification': instance.qualification,
      'course': instance.course,
      'yearOfGraduation': instance.yearOfGraduation?.toIso8601String(),
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
    };
