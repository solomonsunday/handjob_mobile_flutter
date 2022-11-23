// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      contactPhone: json['contactPhone'] as String?,
      address: json['address'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userId: json['userId'] as String?,
      branchId: json['branchId'] as String?,
      adminId: json['adminId'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'contactPhone': instance.contactPhone,
      'address': instance.address,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'branchId': instance.branchId,
      'adminId': instance.adminId,
      'user': instance.user,
    };
