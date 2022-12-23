// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instant_job.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstantJob _$InstantJobFromJson(Map<String, dynamic> json) => InstantJob(
      service: json['service'] as String?,
      region: json['region'] as String?,
      meetupLocation: json['meetupLocation'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      startDate: json['startDate'] as String?,
      now: json['now'] as bool?,
      endDate: json['endDate'] as String?,
      description: json['description'] as String?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstantJobToJson(InstantJob instance) =>
    <String, dynamic>{
      'service': instance.service,
      'region': instance.region,
      'meetupLocation': instance.meetupLocation,
      'lat': instance.lat,
      'lon': instance.lon,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'startDate': instance.startDate,
      'now': instance.now,
      'endDate': instance.endDate,
      'description': instance.description,
      'company': instance.company,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      companyName: json['companyName'] as String?,
      accountType: json['accountType'] as String?,
      address: json['address'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'companyName': instance.companyName,
      'accountType': instance.accountType,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
    };
