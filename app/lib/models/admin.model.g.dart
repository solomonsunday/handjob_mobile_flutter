// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      id: json['id'] as String?,
      businessName: json['businessName'] as String?,
      businessEmail: json['businessEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      address: json['address'] as String?,
      numOfBranches: json['numOfBranches'] as int?,
      userId: json['userId'] as String?,
      registeredAt: json['registeredAt'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'id': instance.id,
      'businessName': instance.businessName,
      'businessEmail': instance.businessEmail,
      'contactPhone': instance.contactPhone,
      'address': instance.address,
      'numOfBranches': instance.numOfBranches,
      'userId': instance.userId,
      'registeredAt': instance.registeredAt,
      'user': instance.user,
    };
