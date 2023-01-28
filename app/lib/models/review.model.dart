import 'package:json_annotation/json_annotation.dart';

part 'review.model.g.dart';

@JsonSerializable()
class Review {
  String? id;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? disabled;
  bool? isSystemDefined;
  String? reviewerAccountId;
  String? reviewerName;
  String? reviewerDisplayName;
  String? applicantId;
  String? applicantName;
  String? jobId;
  String? jobTitle;
  int? rating;
  String? title;
  String? detail;
  bool? verifiedReview;

  Review({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.disabled,
    this.isSystemDefined,
    this.reviewerAccountId,
    this.reviewerName,
    this.reviewerDisplayName,
    this.applicantId,
    this.applicantName,
    this.jobId,
    this.jobTitle,
    this.rating,
    this.title,
    this.detail,
    this.verifiedReview,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
