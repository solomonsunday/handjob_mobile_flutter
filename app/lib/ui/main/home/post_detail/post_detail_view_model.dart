import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/comment.model.dart';
import '../../../../models/user.model.dart';
import '../../../../services/authentication.service.dart';
import '../../../../services/comment.service.dart';

const String CREATE_COMMENT_BUSY = 'CREATE_COMMENT_BUSY';

class PostDetailViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _commentService = locator<CommentService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;
  String? _postId;
  String? get postId => _postId;

  TextEditingController messageController = TextEditingController();

  List<Comment> get comments => _commentService.comments;

  void navigateBack() => _navigationService.back();

  void updatePostId(String postId) {
    _postId = postId;
  }

  Future<void> getComments() async {
    _commentService.comments.clear();
    setBusy(true);
    // notifyListeners();
    try {
      await _commentService.getComments(postId!);
    } on DioError catch (e) {
      print('error commenting: ${e}');
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
      await _commentService.createComment(postId!, formData);
      messageController.clear();
      await _commentService.getComments(postId!);
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CREATE_COMMENT_BUSY, false);
      // notifyListeners();
    }
  }

  replyComment(Comment comment) {
    String textToSelect = '@${comment.authorEmployer}';
    messageController.text = "@${comment.authorEmployer} ";
    messageController.selection =
        TextSelection(baseOffset: 0, extentOffset: textToSelect.length - 1);
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_commentService];
}
