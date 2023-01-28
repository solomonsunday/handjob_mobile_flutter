// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      disabled: json['disabled'] as bool?,
      isSystemDefined: json['isSystemDefined'] as bool?,
      reviewerAccountId: json['reviewerAccountId'] as String?,
      reviewerName: json['reviewerName'] as String?,
      reviewerDisplayName: json['reviewerDisplayName'] as String?,
      applicantId: json['applicantId'] as String?,
      applicantName: json['applicantName'] as String?,
      jobId: json['jobId'] as String?,
      jobTitle: json['jobTitle'] as String?,
      rating: json['rating'] as int?,
      title: json['title'] as String?,
      detail: json['detail'] as String?,
      verifiedReview: json['verifiedReview'] as bool?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDeleted': instance.isDeleted,
      'disabled': instance.disabled,
      'isSystemDefined': instance.isSystemDefined,
      'reviewerAccountId': instance.reviewerAccountId,
      'reviewerName': instance.reviewerName,
      'reviewerDisplayName': instance.reviewerDisplayName,
      'applicantId': instance.applicantId,
      'applicantName': instance.applicantName,
      'jobId': instance.jobId,
      'jobTitle': instance.jobTitle,
      'rating': instance.rating,
      'title': instance.title,
      'detail': instance.detail,
      'verifiedReview': instance.verifiedReview,
    };
