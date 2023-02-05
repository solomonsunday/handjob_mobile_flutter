import 'package:json_annotation/json_annotation.dart';

import 'author.model.dart';
import 'comment.model.dart';

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
  List<Comment>? comments;
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
