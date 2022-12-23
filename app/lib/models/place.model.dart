import 'package:json_annotation/json_annotation.dart';

part 'place.model.g.dart';

@JsonSerializable()
class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;
  double? lat;
  double? lon;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.lat,
    this.lon,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
