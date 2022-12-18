import 'package:json_annotation/json_annotation.dart';

part 'auth.model.g.dart';

@JsonSerializable()
class Auth {
  final String accessToken;
  final String refreshToken;

  final String? id;
  final String? name;
  final String? role;
  final String? accountType;
  final String? imageUrl;
  final String? phoneNumber;
  final String? platform;

  Auth({
    required this.accessToken,
    required this.refreshToken,
    this.id,
    this.name,
    this.role,
    this.accountType,
    this.imageUrl,
    this.phoneNumber,
    this.platform,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
