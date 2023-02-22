import 'package:json_annotation/json_annotation.dart';

part 'socket-user.model.g.dart';

@JsonSerializable()
class SocketUser {
  String userId;
  String email;
  String socketId;

  SocketUser(this.userId, this.email, this.socketId) {}

  factory SocketUser.fromJson(Map<String, dynamic> json) =>
      _$SocketUserFromJson(json);
  Map<String, dynamic> toJson() => _$SocketUserToJson(this);
}
