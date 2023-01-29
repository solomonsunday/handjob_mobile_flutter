import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/post.model.dart';

class PostService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  PostService() {
    listenToReactiveValues([
      posts,
      postMeta,
    ]);
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  PostMeta? _postMeta;
  PostMeta? get postMeta => _postMeta;

  Future<List<Post>> getPosts({int page = 1, int limit = 10}) async {
    var response = await dioClient.get(
      '/post?page=$page&take=$limit',
    );
    _postMeta = PostMeta.fromJson(response.data["meta"]);
    List<Map> mappedPosts =
        (response.data["data"] as List).map((e) => e as Map).toList();
    List<Map<String, dynamic>> newResponsePostMap = mappedPosts.map((e) {
      Map<String, dynamic> obj = {};
      for (var k in e.keys) {
        obj[k] = e[k];
      }
      return obj;
    }).toList();

    List<Post> posts = newResponsePostMap.map((x) => Post.fromJson(x)).toList();
    _posts = posts;
    notifyListeners();
    print('pststs: $_posts');
    return posts;
  }
}
