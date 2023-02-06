import 'package:handjob_mobile/services/comment.service.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../models/comment.model.dart';

const String LIKE_COMMENT = 'LIKE_COMMENT';

class CommentItemViewModel extends ReactiveViewModel {
  final _commentService = locator<CommentService>();

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  Future<void> likeComment(Comment comment) async {
    _isLiked = !_isLiked;
    comment.likes = (comment.likes ?? 0) + 1;
    notifyListeners();
    setBusyForObject(LIKE_COMMENT, true);
    try {
      await _commentService.likeComment(comment.id!);
    } catch (e) {
    } finally {
      setBusyForObject(LIKE_COMMENT, false);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_commentService];
}
