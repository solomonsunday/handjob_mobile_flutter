import 'dart:async';

import 'package:handjob_mobile/services/comment.service.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../models/comment.model.dart';
import '../../../../../models/user.model.dart';
import '../../../../../services/authentication.service.dart';

const String LIKE_COMMENT = 'LIKE_COMMENT';

class CommentItemViewModel extends ReactiveViewModel {
  final _commentService = locator<CommentService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;
  final bool _isLiked = false;
  bool get isLiked => _isLiked;

  Timer? _debounce;

// change debouce duration accordingly
  final Duration _debouceDuration = const Duration(milliseconds: 500);

  Future<void> likeComment(Comment comment) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debouceDuration, () async {
      await handleLikeComment(comment);
    });
  }

  Future<void> handleLikeComment(Comment comment) async {
    comment.liked = comment.liked == null ? true : !comment.liked!;
    if (comment.liked!) {
      comment.likes = comment.likes! + 1;
    } else {
      comment.likes = comment.likes! - 1;
    }
    notifyListeners();
    setBusyForObject(LIKE_COMMENT, true);
    try {
      await _commentService.likeComment(comment.id!);
    } finally {
      setBusyForObject(LIKE_COMMENT, false);
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_commentService];
}
