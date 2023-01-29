import 'package:json_annotation/json_annotation.dart';

part 'post.model.g.dart';

@JsonSerializable()
class Post {
  String? id;
  String? createdBy;
  String? createdAt;
  String? title;
  String? body;
  String? editedAt;
  bool? published;
  bool? suspended;
  String? message;
  int? claps;
  int? views;
  int? likes;
  int? dislikes;
  Author? author;
  List<Comments>? comments;
  List<dynamic>? postMedia;
  int? commentCount;
  bool? liked;

  Post({
    this.id,
    this.createdBy,
    this.createdAt,
    this.title,
    this.body,
    this.editedAt,
    this.published,
    this.suspended,
    this.message,
    this.claps,
    this.views,
    this.likes,
    this.dislikes,
    this.author,
    this.comments,
    this.postMedia,
    this.commentCount,
    this.liked,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class Author {
  String? email;
  bool? emailVerified;
  String? accountType;
  String? firstName;
  String? lastName;
  String? passwordHash;
  String? imageUrl;
  String? socialType;
  String? socialId;
  String? id;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? disabled;
  bool? isSystemDefined;
  String? otherName;
  String? profession;
  String? services;
  String? companyName;
  String? phoneNumber;
  String? profile; //questionable type
  String? contactEmail;
  String? contactPhoneNumber;
  String? role;
  String? dateOfBirth;
  bool? phoneNumberVerified;
  bool? accountVerified;
  bool? isActive;
  bool? smsNotificationActive;
  bool? emailNotificationActive;
  int? rating;
  String? postalCode;
  String? hobbies;
  String? interests;
  String? locations;
  String? address;
  String? website;
  String? yearOfEstablishment;
  String? noOfEmployees;
  int? stateId;
  String? city;
  String? region;
  int? lgaId;
  String? countryId;
  String? socketId;

  Author({
    this.email,
    this.emailVerified,
    this.accountType,
    this.firstName,
    this.lastName,
    this.passwordHash,
    this.imageUrl,
    this.socialType,
    this.socialId,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.disabled,
    this.isSystemDefined,
    this.otherName,
    this.profession,
    this.services,
    this.companyName,
    this.phoneNumber,
    this.profile,
    this.contactEmail,
    this.contactPhoneNumber,
    this.role,
    this.dateOfBirth,
    this.phoneNumberVerified,
    this.accountVerified,
    this.isActive,
    this.smsNotificationActive,
    this.emailNotificationActive,
    this.rating,
    this.postalCode,
    this.hobbies,
    this.interests,
    this.locations,
    this.address,
    this.website,
    this.yearOfEstablishment,
    this.noOfEmployees,
    this.stateId,
    this.city,
    this.region,
    this.lgaId,
    this.countryId,
    this.socketId,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Comments {
  String? id;
  String? createdBy;
  String? createdAt;
  String? message;
  String? editedAt;
  bool? offensive;
  String? authorJobTitle;
  String? authorEmployer;
  int? likes;
  int? dislikes;
  String? postId;
  String? location;
  Author? author;
  bool? liked;

  Comments({
    this.id,
    this.createdBy,
    this.createdAt,
    this.message,
    this.editedAt,
    this.offensive,
    this.authorJobTitle,
    this.authorEmployer,
    this.likes,
    this.dislikes,
    this.postId,
    this.location,
    this.author,
    this.liked,
  });

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}

@JsonSerializable()
class PostMeta {
  int? page;
  int? take;
  int? itemCount;
  int? total;

  PostMeta({
    this.page,
    this.take,
    this.itemCount,
    this.total,
  });

  factory PostMeta.fromJson(Map<String, dynamic> json) =>
      _$PostMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PostMetaToJson(this);
}
