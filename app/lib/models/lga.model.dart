import 'package:json_annotation/json_annotation.dart';

part 'lga.model.g.dart';

@JsonSerializable()
class LGA {
  int? id;
  String? name;
  int? stateId;

  LGA({this.id, this.name, this.stateId});

  factory LGA.fromJson(Map<String, dynamic> json) => _$LGAFromJson(json);
  Map<String, dynamic> toJson() => _$LGAToJson(this);
}
