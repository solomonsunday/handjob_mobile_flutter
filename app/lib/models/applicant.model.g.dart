// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      name: json['name'] as String?,
      applicationId: json['applicationId'] as String?,
      cvUrl: json['cvUrl'] as String?,
      applicantId: json['applicantId'] as String?,
      location: json['location'] as String?,
      occupation: json['occupation'] as String?,
      rating: json['rating'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      biography: json['biography'] as String?,
      address: json['address'] as String?,
      accepted: json['accepted'] as bool?,
      rejected: json['rejected'] as bool?,
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'name': instance.name,
      'applicationId': instance.applicationId,
      'cvUrl': instance.cvUrl,
      'applicantId': instance.applicantId,
      'location': instance.location,
      'occupation': instance.occupation,
      'rating': instance.rating,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'biography': instance.biography,
      'address': instance.address,
      'accepted': instance.accepted,
      'rejected': instance.rejected,
    };
