import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? password;
  bool? isVerified;
  String? role;
  String? token;
  bool? disabled;
  String? tokenExp;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.email,
    this.password,
    this.isVerified,
    this.role,
    this.token,
    this.disabled,
    this.tokenExp,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
