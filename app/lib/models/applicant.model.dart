import 'package:json_annotation/json_annotation.dart';

part 'applicant.model.g.dart';

@JsonSerializable()
class Applicant {
  String? name;
  String? applicationId;
  String? cvUrl;
  String? applicantId;
  String? location;
  String? occupation;
  int? rating;
  String? phoneNumber;
  String? imageUrl;
  String? biography;
  String? address;
  bool? accepted;
  bool? rejected;

  Applicant({
    this.name,
    this.applicationId,
    this.cvUrl,
    this.applicantId,
    this.location,
    this.occupation,
    this.rating,
    this.phoneNumber,
    this.imageUrl,
    this.biography,
    this.address,
    this.accepted,
    this.rejected,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) =>
      _$ApplicantFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicantToJson(this);
}
