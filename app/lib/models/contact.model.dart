import 'package:handjob_mobile/models/experience.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.model.g.dart';

@JsonSerializable()
class Contact {
  String? id;
  String? firstName;
  String? lastName;
  String? imageUrl;
  String? email;
  String? phoneNumber;
  String? accountType;
  int? rating;
  bool? blocked;
  List<Experience>? experiences;

  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.email,
    this.phoneNumber,
    this.accountType,
    this.rating,
    this.blocked,
    this.experiences,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
