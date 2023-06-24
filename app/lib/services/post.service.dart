import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/meta.model.dart';
import '../models/post.model.dart';

class PostService with ListenableServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  PostService() {
    listenToReactiveValues([
      posts,
      postMeta,
      loadingPosts,
    ]);
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;
  bool _loadingPosts = false;
  bool get loadingPosts => _loadingPosts;

  Meta? _postMeta;
  Meta? get postMeta => _postMeta;

  Future<List<Post>> getPosts(
      {int page = 1, int limit = 10, String? search}) async {
    _loadingPosts = true;
    String url = '/post?page=$page&take=$limit';
    if (search != null) {
      var response = await dioClient.get(
        '/post/search?page=$page&search=$search',
      );

      List<Map<String, dynamic>> newResponsePostMap =
          (response.data as List).map((e) {
        Map<String, dynamic> obj = {};
        for (var k in e.keys) {
          obj[k] = e[k];
        }
        return obj;
      }).toList();

      List<Post> posts =
          newResponsePostMap.map((x) => Post.fromJson(x)).toList();
      _posts = posts;
      print('response search: ${posts.map((e) => e.toJson()).toList()}');
      _loadingPosts = false;
      notifyListeners();
      return posts;
    }
    var response = await dioClient.get(
      url,
    );
    _postMeta = Meta.fromJson(response.data["meta"]);
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
    _loadingPosts = false;
    notifyListeners();
    print('pststs: ${_posts.map((e) => e.toJson()).toList()}');
    return posts;
  }

  Future<void> createPost(Map map) async {
    var formData = FormData.fromMap({
      ...map,
    });
    if (map.containsKey('files')) {
      File file = map['files'];
      formData.files
          .add(MapEntry('files', MultipartFile.fromFileSync(file.path)));
    }
    var response = await dioClient.post(
      '/post',
      data: formData,
    );
    print('response data: ${response.data}');
  }

  Future<Post> getPost(String postId) async {
    var response = await dioClient.get('/post/$postId');
    return Post.fromJson(response.data);
  }

  Future<bool> likePost(String postId) async {
    await dioClient.put('/post/like/$postId');
    return true;
  }

  Future<bool> disLikePost(String postId) async {
    await dioClient.put('/post/dislike/$postId');
    return true;
  }

  Future<Post> deletePost(String postId) async {
    var response = await dioClient.delete("/post/$postId");

    Post post = Post.fromJson(response.data);
    _posts.removeWhere((element) => element.id == post.id);
    notifyListeners();
    return post;
  }

  // edit: (id, data) => requests.put(`/post/${id}`, data),
  // load: (page, take) =>
  //   requests.get(
  //     `/post?${new URLSearchParams({ page: page, take: take }).toString()}`
  //   ),
  // loadByUserId: (id, page, take) =>
  //   requests.get(
  //     `/post/user/${id}?${new URLSearchParams({
  //       page: page,
  //       take: take,
  //     }).toString()}`
  //   ),
  // view: (id) => requests.get(`/post/${id}`),
  // search: (page, search) => requests.get("/post/search", page, search),
  // like: (id) => requests.put(`/post/like/${id}`),
  // dislike: (id) => requests.put(`/post/dislike/${id}`),
  // postCount: () => requests.get("/post/count"),
  // postCountByUser: (userId) => requests.get(`/post/user/${userId}/count`),
  // delete: (id) => requests.del(`/post/${id}`),
}
