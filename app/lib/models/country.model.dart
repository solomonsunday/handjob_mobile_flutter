import 'package:json_annotation/json_annotation.dart';

part 'country.model.g.dart';

@JsonSerializable()
class Country {
  int? id;
  String? code;
  String? name;
  String? capital;

  Country({this.id, this.code, this.name, this.capital});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
