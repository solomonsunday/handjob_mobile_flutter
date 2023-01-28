import 'package:handjob_mobile/models/education.model.dart';
import 'package:handjob_mobile/models/experience.model.dart';
import 'package:handjob_mobile/models/review.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? imageUrl;
  String? address;
  String? profession;
  String? companyName;
  String? contactPhoneNumber;
  String? postalCode;
  String? contactEmail;
  List<String>? locations;
  String? phoneNumber;
  bool? emailVerified;
  bool? phoneNumberVerified;
  dynamic profile;
  String? accountType;
  String? role;
  dynamic dateOfBirth;
  List<dynamic>? hobbies;
  List<dynamic>? interests;
  List<String>? services;
  dynamic city;
  List<dynamic>? skills;
  List<Experience>? experiences;
  List<Education>? educations;
  List<Review>? reviews;
  dynamic yearOfEstablishment;
  dynamic website;
  dynamic noOfEmployees;
  List<String>? portfolios;
  String? lga;
  String? state;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.address,
    this.profession,
    this.companyName,
    this.contactPhoneNumber,
    this.postalCode,
    this.contactEmail,
    this.locations,
    this.phoneNumber,
    this.emailVerified,
    this.phoneNumberVerified,
    this.profile,
    this.accountType,
    this.role,
    this.dateOfBirth,
    this.hobbies,
    this.interests,
    this.services,
    this.city,
    this.skills,
    this.experiences,
    this.educations,
    this.reviews,
    this.yearOfEstablishment,
    this.website,
    this.noOfEmployees,
    this.portfolios,
    this.lga,
    this.state,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
