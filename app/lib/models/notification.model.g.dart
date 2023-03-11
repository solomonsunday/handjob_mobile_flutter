// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      disabled: json['disabled'] as bool?,
      isSystemDefined: json['isSystemDefined'] as bool?,
      message: json['message'] as String?,
      url: json['url'] as String?,
      deleted: json['deleted'] as bool?,
      isGeneral: json['isGeneral'] as bool?,
      accountId: json['accountId'] as String?,
      entityId: json['entityId'] as String?,
      recieverId: json['recieverId'] as String?,
      senderId: json['senderId'] as String?,
      senderImageUrl: json['senderImageUrl'] as String?,
      notificationType: json['notificationType'] as String?,
      seen: json['seen'] as bool?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDeleted': instance.isDeleted,
      'disabled': instance.disabled,
      'isSystemDefined': instance.isSystemDefined,
      'message': instance.message,
      'url': instance.url,
      'deleted': instance.deleted,
      'isGeneral': instance.isGeneral,
      'accountId': instance.accountId,
      'entityId': instance.entityId,
      'recieverId': instance.recieverId,
      'senderId': instance.senderId,
      'senderImageUrl': instance.senderImageUrl,
      'notificationType': instance.notificationType,
      'seen': instance.seen,
    };
