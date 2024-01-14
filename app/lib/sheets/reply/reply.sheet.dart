import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/comment.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../ui/main/home/post_detail/comment_item/comment_item_view.dart';

class ReplySheet extends StatelessWidget {
  const ReplySheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReplySheetViewModel>.reactive(
        viewModelBuilder: () => ReplySheetViewModel(),
        onViewModelReady: (model) {
          List<Comment> comments = request?.data as List<Comment>;
          model.setComments(comments);
        },
        builder: (context, model, child) {
          return BottomSheetContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p2,
              vertical: AppPadding.p10,
            ),
            onClose: () => completer!(SheetResponse(confirmed: false)),
            child: model.comments.isEmpty
                ? const Center(
                    child: Text('No comments available'),
                  )
                : Column(
                    children: [
                      const SizedBox(height: AppSize.s12),
                      const Center(
                        child: Text(
                          'Replies',
                          style: TextStyle(
                            fontSize: FontSize.s18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s20),
                      Expanded(
                          child: ListView.builder(
                        itemCount: model.comments.length,
                        itemBuilder: (context, index) {
                          return CommentItemView(
                            comment: model.comments[index],
                            isReplyView: true,
                          );
                        },
                      )),
                      const Row(
                        children: [],
                      ),
                    ],
                  ),
          );
        });
  }
}

class ReplySheetViewModel extends BaseViewModel {
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }
}
