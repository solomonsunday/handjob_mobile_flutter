// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      editedAt: json['editedAt'] as String?,
      published: json['published'] as bool?,
      suspended: json['suspended'] as bool?,
      message: json['message'] as String?,
      claps: json['claps'] as int?,
      views: json['views'] as int?,
      likes: json['likes'] as int?,
      dislikes: json['dislikes'] as int?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      postMedia: json['postMedia'] as List<dynamic>?,
      commentCount: json['commentCount'] as int?,
      liked: json['liked'] as bool?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'body': instance.body,
      'editedAt': instance.editedAt,
      'published': instance.published,
      'suspended': instance.suspended,
      'message': instance.message,
      'claps': instance.claps,
      'views': instance.views,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'author': instance.author,
      'comments': instance.comments,
      'postMedia': instance.postMedia,
      'commentCount': instance.commentCount,
      'liked': instance.liked,
    };
