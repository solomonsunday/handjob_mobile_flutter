import 'package:json_annotation/json_annotation.dart';

import 'conversation.model.dart';

part 'chat.model.g.dart';

@JsonSerializable()
class Chat {
  List<Conversation>? conversation;
  Partner? partner;
  Partner? owner;

  Chat({
    this.conversation,
    this.partner,
    this.owner,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
