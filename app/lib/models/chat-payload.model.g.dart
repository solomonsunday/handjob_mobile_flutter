// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat-payload.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPayload _$ChatPayloadFromJson(Map<String, dynamic> json) => ChatPayload(
      title: json['title'] as String?,
      recieverId: json['recieverId'] as String?,
      senderId: json['senderId'] as String?,
      message: json['message'] as String?,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ChatPayloadToJson(ChatPayload instance) =>
    <String, dynamic>{
      'title': instance.title,
      'recieverId': instance.recieverId,
      'senderId': instance.senderId,
      'message': instance.message,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
      'videoUrl': instance.videoUrl,
      'createdAt': instance.createdAt,
    };
