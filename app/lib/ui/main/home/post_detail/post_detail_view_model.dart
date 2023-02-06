import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/comment.model.dart';
import '../../../../services/comment.service.dart';

class PostDetailViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _commentService = locator<CommentService>();

  String? _postId;
  String? get postId => _postId;

  TextEditingController messageController = TextEditingController();

  List<Comment> get comments => _commentService.comments;

  void navigateBack() => _navigationService.back();

  void updatePostId(String postId) {
    _postId = postId;
  }

  Future<void> getComments() async {
    try {
      await _commentService.getComments(postId!);
    } on DioError catch (e) {}
  }

  Future<void> createComment() async {
    Map<String, dynamic> formData = {
      "message": messageController.text,
    };
    print('formdata: $formData');
    setBusy(true);
    try {
      await _commentService.createComment(postId!, formData);
    } on DioError catch (e) {
    } finally {
      messageController.clear();
      setBusy(false);
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_commentService];
}
