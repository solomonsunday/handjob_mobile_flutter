// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      isVerified: json['isVerified'] as bool?,
      role: json['role'] as String?,
      token: json['token'] as String?,
      disabled: json['disabled'] as bool?,
      tokenExp: json['tokenExp'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'isVerified': instance.isVerified,
      'role': instance.role,
      'token': instance.token,
      'disabled': instance.disabled,
      'tokenExp': instance.tokenExp,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
