// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      message: json['message'] as String?,
      editedAt: json['editedAt'] as String?,
      offensive: json['offensive'] as bool?,
      authorJobTitle: json['authorJobTitle'] as String?,
      authorEmployer: json['authorEmployer'] as String?,
      likes: json['likes'] as int?,
      dislikes: json['dislikes'] as int?,
      postId: json['postId'] as String?,
      location: json['location'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      liked: json['liked'] as bool?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'message': instance.message,
      'editedAt': instance.editedAt,
      'offensive': instance.offensive,
      'authorJobTitle': instance.authorJobTitle,
      'authorEmployer': instance.authorEmployer,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'postId': instance.postId,
      'location': instance.location,
      'author': instance.author,
      'liked': instance.liked,
    };
