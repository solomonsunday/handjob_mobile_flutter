import 'package:json_annotation/json_annotation.dart';

part 'rtc.model.g.dart';

@JsonSerializable()
class RtcToken {
  String? rtcToken;

  RtcToken({
    this.rtcToken,
  });

  factory RtcToken.fromJson(Map<String, dynamic> json) =>
      _$RtcTokenFromJson(json);
  Map<String, dynamic> toJson() => _$RtcTokenToJson(this);
}
