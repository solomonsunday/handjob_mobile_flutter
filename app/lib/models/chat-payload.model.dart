import 'package:json_annotation/json_annotation.dart';

part 'chat-payload.model.g.dart';

@JsonSerializable()
class ChatPayload {
  String? title;
  String? recieverId;
  String? senderId;
  String? message;
  String? imageUrl;
  String? audioUrl;
  String? videoUrl;
  String? createdAt;

  ChatPayload({
    this.title,
    this.recieverId,
    this.senderId,
    this.message,
    this.imageUrl,
    this.audioUrl,
    this.videoUrl,
    this.createdAt,
  });

  factory ChatPayload.fromJson(Map<String, dynamic> json) =>
      _$ChatPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$ChatPayloadToJson(this);
}
