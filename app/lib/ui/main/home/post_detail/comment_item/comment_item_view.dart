import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../../models/comment.model.dart';
import '../../../../../utils/helpers.dart';
import 'comment_item_view_model.dart';

class CommentItemView extends StatelessWidget {
  const CommentItemView({
    Key? key,
    required this.comment,
    this.replyComment,
    this.isReplyView = false,
  }) : super(key: key);
  final Comment? comment;
  final Function(Comment)? replyComment;
  final bool isReplyView;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentItemViewModel>.reactive(
        viewModelBuilder: () => CommentItemViewModel(),
        builder: (context, model, _) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p28,
              vertical: AppPadding.p10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomAvatar(
                  // imgUrl: "",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: AppSize.s14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      comment?.author == null
                          ? Text(
                              '${model.currentUser?.firstName} ${model.currentUser?.lastName}')
                          : Text(
                              '${comment?.author?.firstName} ${comment?.author?.lastName}'),
                      const SizedBox(height: AppSize.s2),
                      Text('${comment?.message}'),
                      const SizedBox(height: AppSize.s2),
                      Row(children: [
                        Text(
                          getTimeDiff(comment!.createdAt!),
                          style: getRegularStyle(
                            color: ColorManager.kGrey4,
                            fontSize: FontSize.s11,
                          ),
                        ),
                        const SizedBox(width: AppSize.s12),
                        Text(
                          '${comment?.likes} likes',
                          style: getRegularStyle(
                            color: ColorManager.kGrey4,
                            fontSize: FontSize.s11,
                          ),
                        ),
                        const SizedBox(width: AppSize.s12),
                        GestureDetector(
                          onTap: () => replyComment!(comment!),
                          child: Text(
                            'Reply',
                            style: getRegularStyle(
                              color: ColorManager.kGrey4,
                              fontSize: FontSize.s11,
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(height: AppSize.s8),
                      isReplyView
                          ? Container()
                          : _buildCommentReplies(
                              count: comment?.replies?.length ?? 0,
                              onReplyTap: () =>
                                  model.onReplyTap(comment?.replies ?? []),
                            ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => model.likeComment(comment!),
                  child: Icon(
                    (comment?.liked ?? false) || model.isLiked
                        ? Icons.favorite
                        : Icons.favorite_outline,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildCommentReplies({required int count, Function()? onReplyTap}) {
    return GestureDetector(
      onTap: onReplyTap,
      child: Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDash(),
              const SizedBox(width: AppSize.s12),
              Text(
                'View $count more replies',
                style: getRegularStyle(
                  color: ColorManager.kGrey4,
                  fontSize: 8,
                ),
              ),
              const SizedBox(width: AppSize.s12),
              _buildDash(),
            ]),
      ),
    );
  }

  _buildDash({double? width}) {
    return Container(
      width: width ?? 24,
      height: 1,
      decoration: const BoxDecoration(
        color: ColorManager.kGrey3,
      ),
    );
  }
}
