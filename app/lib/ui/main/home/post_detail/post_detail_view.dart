import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/post.model.dart';
import 'package:handjob_mobile/ui/main/home/post_detail/post_detail_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/comment.model.dart';
import '../../home_card.dart';
import 'comment_item/comment_item_view.dart';

@FormView(fields: [FormTextField(name: 'message')])
class PostDetailView extends StatelessWidget {
  const PostDetailView({
    Key? key,
    required this.post,
    required this.postIndex,
  }) : super(key: key);
  final Post post;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailViewModel>.nonReactive(
      viewModelBuilder: () => PostDetailViewModel(),
      onModelReady: (model) {
        model.updatePostId(post.id!);
        model.getComments();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Navbar(
            leadingIcon: const Icon(
              Icons.arrow_back,
              color: ColorManager.kDarkColor,
            ),
            onTap: model.navigateBack,
            title: "Post",
            fontsize: FontSize.s16,
          ),
          body: Stack(
            children: [
              CommentView(
                post: post,
                postIndex: postIndex,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CommentFormView(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentView extends ViewModelWidget<PostDetailViewModel> {
  const CommentView({
    Key? key,
    required this.post,
    required this.postIndex,
  }) : super(key: key);
  final Post post;
  final int postIndex;

  @override
  Widget build(BuildContext context, PostDetailViewModel model) {
    return ListView(
      children: [
        Column(children: [
          const SizedBox(height: AppSize.s24),
          HomeCard(
            post: post,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
            child: Divider(
              thickness: 1,
              color: ColorManager.kGrey1,
            ),
          ),
        ]),
        model.comments.isEmpty
            ? Center(
                child: Text(
                  "No comments available",
                  style: getSemiBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: model.comments.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CommentItemView(
                    comment: model.comments[index],
                    replyComment: model.replyComment,
                  );
                }),
      ],
    );
  }
}

class CommentFormView extends ViewModelWidget<PostDetailViewModel> {
  const CommentFormView({super.key});

  @override
  Widget build(BuildContext context, PostDetailViewModel model) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p24),
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
      ),
      child: InputField(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: BorderSide(
            color: ColorManager.kDarkColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: BorderSide(
            color: ColorManager.kGrey3,
          ),
        ),
        prefixIcon: Icon(Icons.person),
        suffixIcon: GestureDetector(
          onTap: model.createComment,
          child: Icon(
              color: model.messageController.text.isEmpty
                  ? ColorManager.kGrey
                  : ColorManager.kPrimaryColor,
              Icons.send),
        ),
        controller: model.messageController,
      ),
    );
  }
}
