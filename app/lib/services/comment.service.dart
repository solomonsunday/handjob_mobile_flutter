import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/comment.model.dart';
import '../models/meta.model.dart';
import '../models/post.model.dart';

class CommentService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  CommentService() {
    listenToReactiveValues([
      comments,
      commentMeta,
    ]);
  }

  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  Meta? _commentMeta;
  Meta? get commentMeta => _commentMeta;

  Future<List<Comment>> getComments(String postId) async {
    var response = await dioClient.get(
      '​/comment​/post​/$postId',
    );
    _commentMeta = Meta.fromJson(response.data["meta"]);
    List<Map> mappedPosts =
        (response.data["data"] as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponsePostMap = mappedPosts.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();

    List<Comment> comments =
        newResponsePostMap.map((x) => Comment.fromJson(x)).toList();
    _comments = comments;
    notifyListeners();
    print('comments: $_comments');
    return comments;
  }

  Future<Comment> createComment(
      String postId, Map<String, dynamic> formData) async {
    var response = await dioClient.post(
      '/comment/$postId',
      data: formData,
    );
    Comment comment = Comment.fromJson(response.data);
    _comments = [..._comments, comment];
    notifyListeners();
    return comment;
  }

  Future<Comment> likeComment(String commentId) async {
    var response = await dioClient.put(
      '/comment/like/$commentId',
    );
    print('resposne comment: ${response.data}');
    return Comment.fromJson(response.data);
  }

  Future<Comment> deleteComment(String commentId) async {
    var response = await dioClient.delete('/comment/$commentId');
    return Comment.fromJson(response.data);
  }
}
