// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      id: json['id'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      accountType: json['accountType'] as String?,
      imageUrl: json['imageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      platform: json['platform'] as String?,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'accountType': instance.accountType,
      'imageUrl': instance.imageUrl,
      'phoneNumber': instance.phoneNumber,
      'platform': instance.platform,
    };
