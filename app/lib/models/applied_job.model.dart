import 'package:json_annotation/json_annotation.dart';

part 'applied_job.model.g.dart';

@JsonSerializable()
class AppliedJob {
  String? description;
  String? startDate;
  String? endDate;
  String? location;
  String? createdBy;
  bool? accepted;
  bool? rejected;
  String? cvUrl;
  String? jobId;
  String? service;
  String? address;
  String? region;
  String? createdAt;
  String? meetupLocation;

  AppliedJob({
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.createdBy,
    this.accepted,
    this.rejected,
    this.cvUrl,
    this.jobId,
    this.service,
    this.address,
    this.region,
    this.createdAt,
    this.meetupLocation,
  });

  factory AppliedJob.fromJson(Map<String, dynamic> json) =>
      _$AppliedJobFromJson(json);
  Map<String, dynamic> toJson() => _$AppliedJobToJson(this);
}
