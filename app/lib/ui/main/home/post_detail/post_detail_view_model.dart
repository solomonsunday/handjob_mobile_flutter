import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/comment.model.dart';
import '../../../../models/post.model.dart';
import '../../../../models/user.model.dart';
import '../../../../services/authentication.service.dart';
import '../../../../services/comment.service.dart';

const String CREATE_COMMENT_BUSY = 'CREATE_COMMENT_BUSY';

class PostDetailViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _commentService = locator<CommentService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;
  Post? _post;
  Post? get postId => _post;

  TextEditingController messageController = TextEditingController();

  List<Comment> get comments => _commentService.comments;

  void navigateBack() => _navigationService.back();

  void updatePost(Post post) {
    _post = post;
  }

  Future<void> getComments() async {
    _commentService.comments.clear();
    setBusy(true);
    // notifyListeners();
    try {
      await _commentService.getComments(_post!.id!);
    } on DioError catch (e) {
      print('error commenting: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> createComment() async {
    if (messageController.text.isEmpty) return;

    Map<String, dynamic> formData = {
      "message": messageController.text,
    };
    print('formdata: $formData');
    setBusyForObject(CREATE_COMMENT_BUSY, true);
    try {
      await _commentService.createComment(_post!.id!, formData);
      messageController.clear();
      _post!.commentCount = _post!.commentCount! + 1;
      notifyListeners();
    } finally {
      setBusyForObject(CREATE_COMMENT_BUSY, false);
      await _commentService.getComments(_post!.id!);
      notifyListeners();
    }
  }

  replyComment(Comment comment) async {
    print('comment ${comment?.author?.toJson()}');
    String textToSelect = '@${comment.author?.firstName}';
    messageController.text = "@${comment.author?.firstName} ";
    messageController.selection =
        TextSelection(baseOffset: 0, extentOffset: textToSelect.length - 1);
    // notifyListeners();
     if (messageController.text.isEmpty) return;

    Map<String, dynamic> formData = {
      "message": messageController.text,
      "replyTo": comment.id,
    };
    print('formdata: $formData');
    setBusyForObject(CREATE_COMMENT_BUSY, true);
    try {
      await _commentService.createComment(_post!.id!, formData);
      messageController.clear();
      _post!.commentCount = _post!.commentCount! + 1;
      notifyListeners();
    } finally {
      setBusyForObject(CREATE_COMMENT_BUSY, false);
      await _commentService.getComments(_post!.id!);
      notifyListeners();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_commentService];
}
