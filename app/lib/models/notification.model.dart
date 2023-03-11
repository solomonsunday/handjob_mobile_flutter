import 'package:json_annotation/json_annotation.dart';

part 'notification.model.g.dart';

@JsonSerializable()
class Notification {
  String? id;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? disabled;
  bool? isSystemDefined;
  String? message;
  String? url;
  bool? deleted;
  bool? isGeneral;
  String? accountId;
  String? entityId;
  String? recieverId;
  String? senderId;
  String? senderImageUrl;
  String? notificationType;
  bool? seen;

  Notification({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.disabled,
    this.isSystemDefined,
    this.message,
    this.url,
    this.deleted,
    this.isGeneral,
    this.accountId,
    this.entityId,
    this.recieverId,
    this.senderId,
    this.senderImageUrl,
    this.notificationType,
    this.seen,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
