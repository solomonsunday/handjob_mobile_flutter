// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      accountType: json['accountType'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      passwordHash: json['passwordHash'] as String?,
      imageUrl: json['imageUrl'] as String?,
      socialType: json['socialType'] as String?,
      socialId: json['socialId'] as String?,
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      disabled: json['disabled'] as bool?,
      isSystemDefined: json['isSystemDefined'] as bool?,
      otherName: json['otherName'] as String?,
      profession: json['profession'] as String?,
      services: json['services'] as String?,
      companyName: json['companyName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profile: json['profile'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactPhoneNumber: json['contactPhoneNumber'] as String?,
      role: json['role'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      phoneNumberVerified: json['phoneNumberVerified'] as bool?,
      accountVerified: json['accountVerified'] as bool?,
      isActive: json['isActive'] as bool?,
      smsNotificationActive: json['smsNotificationActive'] as bool?,
      emailNotificationActive: json['emailNotificationActive'] as bool?,
      rating: json['rating'] as int?,
      postalCode: json['postalCode'] as String?,
      hobbies: json['hobbies'] as String?,
      interests: json['interests'] as String?,
      locations: json['locations'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      yearOfEstablishment: json['yearOfEstablishment'] as String?,
      noOfEmployees: json['noOfEmployees'] as String?,
      stateId: json['stateId'] as int?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      lgaId: json['lgaId'] as int?,
      countryId: json['countryId'] as String?,
      socketId: json['socketId'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'accountType': instance.accountType,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'passwordHash': instance.passwordHash,
      'imageUrl': instance.imageUrl,
      'socialType': instance.socialType,
      'socialId': instance.socialId,
      'id': instance.id,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDeleted': instance.isDeleted,
      'disabled': instance.disabled,
      'isSystemDefined': instance.isSystemDefined,
      'otherName': instance.otherName,
      'profession': instance.profession,
      'services': instance.services,
      'companyName': instance.companyName,
      'phoneNumber': instance.phoneNumber,
      'profile': instance.profile,
      'contactEmail': instance.contactEmail,
      'contactPhoneNumber': instance.contactPhoneNumber,
      'role': instance.role,
      'dateOfBirth': instance.dateOfBirth,
      'phoneNumberVerified': instance.phoneNumberVerified,
      'accountVerified': instance.accountVerified,
      'isActive': instance.isActive,
      'smsNotificationActive': instance.smsNotificationActive,
      'emailNotificationActive': instance.emailNotificationActive,
      'rating': instance.rating,
      'postalCode': instance.postalCode,
      'hobbies': instance.hobbies,
      'interests': instance.interests,
      'locations': instance.locations,
      'address': instance.address,
      'website': instance.website,
      'yearOfEstablishment': instance.yearOfEstablishment,
      'noOfEmployees': instance.noOfEmployees,
      'stateId': instance.stateId,
      'city': instance.city,
      'region': instance.region,
      'lgaId': instance.lgaId,
      'countryId': instance.countryId,
      'socketId': instance.socketId,
    };
