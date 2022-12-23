import 'package:handjob_mobile/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instant_job.model.g.dart';

@JsonSerializable()
class InstantJob {
  String? service;
  String? region;
  String? meetupLocation;
  double? lat;
  double? lon;
  String? address;
  String? phoneNumber;
  String? startDate;
  bool? now;
  String? endDate;
  String? description;
  Company? company;

  InstantJob({
    this.service,
    this.region,
    this.meetupLocation,
    this.lat,
    this.lon,
    this.address,
    this.phoneNumber,
    this.startDate,
    this.now,
    this.endDate,
    this.description,
    this.company,
  });

  factory InstantJob.fromJson(Map<String, dynamic> json) =>
      _$InstantJobFromJson(json);
  Map<String, dynamic> toJson() => _$InstantJobToJson(this);
}

@JsonSerializable()
class Company {
  String? id;
  String? firstName;
  String? lastName;
  String? companyName;
  String? accountType;
  String? address;
  String? imageUrl;

  Company({
    this.id,
    this.firstName,
    this.lastName,
    this.companyName,
    this.accountType,
    this.address,
    this.imageUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
