// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      address: json['address'] as String?,
      profession: json['profession'] as String?,
      companyName: json['companyName'] as String?,
      contactPhoneNumber: json['contactPhoneNumber'] as String?,
      postalCode: json['postalCode'] as String?,
      contactEmail: json['contactEmail'] as String?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      phoneNumberVerified: json['phoneNumberVerified'] as bool?,
      profile: json['profile'],
      accountType: json['accountType'] as String?,
      role: json['role'] as String?,
      dateOfBirth: json['dateOfBirth'],
      hobbies: json['hobbies'] as List<dynamic>?,
      interests: json['interests'] as List<dynamic>?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      city: json['city'],
      skills: json['skills'] as List<dynamic>?,
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      educations: (json['educations'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      yearOfEstablishment: json['yearOfEstablishment'],
      website: json['website'],
      noOfEmployees: json['noOfEmployees'],
      portfolios: (json['portfolios'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lga: json['lga'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'profession': instance.profession,
      'companyName': instance.companyName,
      'contactPhoneNumber': instance.contactPhoneNumber,
      'postalCode': instance.postalCode,
      'contactEmail': instance.contactEmail,
      'locations': instance.locations,
      'phoneNumber': instance.phoneNumber,
      'emailVerified': instance.emailVerified,
      'phoneNumberVerified': instance.phoneNumberVerified,
      'profile': instance.profile,
      'accountType': instance.accountType,
      'role': instance.role,
      'dateOfBirth': instance.dateOfBirth,
      'hobbies': instance.hobbies,
      'interests': instance.interests,
      'services': instance.services,
      'city': instance.city,
      'skills': instance.skills,
      'experiences': instance.experiences,
      'educations': instance.educations,
      'reviews': instance.reviews,
      'yearOfEstablishment': instance.yearOfEstablishment,
      'website': instance.website,
      'noOfEmployees': instance.noOfEmployees,
      'portfolios': instance.portfolios,
      'lga': instance.lga,
      'state': instance.state,
    };
