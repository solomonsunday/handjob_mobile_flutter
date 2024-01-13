import 'package:json_annotation/json_annotation.dart';

import 'author.model.dart';

part 'comment.model.g.dart';

@JsonSerializable()
class Comment {
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
  List<Comment>? replies;

  Comment({
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
    this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
