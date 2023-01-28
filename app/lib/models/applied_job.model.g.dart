// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_job.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedJob _$AppliedJobFromJson(Map<String, dynamic> json) => AppliedJob(
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      location: json['location'] as String?,
      createdBy: json['createdBy'] as String?,
      accepted: json['accepted'] as bool?,
      rejected: json['rejected'] as bool?,
      cvUrl: json['cvUrl'] as String?,
      jobId: json['jobId'] as String?,
      service: json['service'] as String?,
      address: json['address'] as String?,
      region: json['region'] as String?,
      createdAt: json['createdAt'] as String?,
      meetupLocation: json['meetupLocation'] as String?,
    );

Map<String, dynamic> _$AppliedJobToJson(AppliedJob instance) =>
    <String, dynamic>{
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'location': instance.location,
      'createdBy': instance.createdBy,
      'accepted': instance.accepted,
      'rejected': instance.rejected,
      'cvUrl': instance.cvUrl,
      'jobId': instance.jobId,
      'service': instance.service,
      'address': instance.address,
      'region': instance.region,
      'createdAt': instance.createdAt,
      'meetupLocation': instance.meetupLocation,
    };
