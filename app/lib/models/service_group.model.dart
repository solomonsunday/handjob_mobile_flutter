import 'package:json_annotation/json_annotation.dart';

part 'service_group.model.g.dart';

@JsonSerializable()
class ServiceGroup {
  int? id;
  String? name;
  String? description;

  ServiceGroup({
    this.id,
    this.name,
    this.description,
  });

  factory ServiceGroup.fromJson(Map<String, dynamic> json) =>
      _$ServiceGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceGroupToJson(this);
}
