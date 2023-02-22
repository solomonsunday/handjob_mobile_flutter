// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket-user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketUser _$SocketUserFromJson(Map<String, dynamic> json) => SocketUser(
      json['userId'] as String,
      json['email'] as String,
      json['socketId'] as String,
    );

Map<String, dynamic> _$SocketUserToJson(SocketUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'socketId': instance.socketId,
    };
