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
  bool _isLiked = false;
  bool get isLiked => _isLiked;

  Future<void> likeComment(Comment comment) async {
    _isLiked = !_isLiked;
    comment.likes = (comment.likes ?? 0) + 1;
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
