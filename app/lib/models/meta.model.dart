import 'package:json_annotation/json_annotation.dart';

part 'meta.model.g.dart';

@JsonSerializable()
class Meta {
  int? page;
  int? take;
  int? itemCount;
  int? total;

  Meta({
    this.page,
    this.take,
    this.itemCount,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
