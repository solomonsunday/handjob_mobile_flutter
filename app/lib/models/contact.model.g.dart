// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      accountType: json['accountType'] as String?,
      rating: json['rating'] as int?,
      blocked: json['blocked'] as bool?,
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'accountType': instance.accountType,
      'rating': instance.rating,
      'blocked': instance.blocked,
      'experiences': instance.experiences,
    };
