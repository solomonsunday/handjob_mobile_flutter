import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/post.model.dart';
import 'package:handjob_mobile/ui/main/home/post_detail/post_detail_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../home_card.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailViewModel>.nonReactive(
      viewModelBuilder: () => PostDetailViewModel(),
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
              // ListView(
              //   children: [HomeCard(), CommentView()],
              // ),
              CommentView(post: post),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
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
                      onTap: () {},
                      child: Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentView extends StatelessWidget {
  const CommentView({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(children: [
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
        ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: (post.comments ?? []).length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CommentItemView(
                  comment:
                      post.comments!.isEmpty ? null : post.comments?[index]);
            }),
      ],
    );
  }
}

class CommentItemView extends StatefulWidget {
  CommentItemView({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final Comments? comment;

  @override
  State<CommentItemView> createState() => _CommentItemViewState();
}

class _CommentItemViewState extends State<CommentItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p28,
          vertical: AppPadding.p10,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAvatar(
                width: 40,
                height: 40,
              ),
              SizedBox(width: AppSize.s14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${widget.comment?.author?.firstName} ${widget.comment?.author?.lastName}'),
                    SizedBox(height: AppSize.s2),
                    Text('${widget.comment?.message}'),
                    SizedBox(height: AppSize.s2),
                    Row(children: [
                      Text(
                        '8h',
                        style: getRegularStyle(
                          color: ColorManager.kGrey4,
                          fontSize: FontSize.s11,
                        ),
                      ),
                      SizedBox(width: AppSize.s12),
                      Text(
                        '12 likes',
                        style: getRegularStyle(
                          color: ColorManager.kGrey4,
                          fontSize: FontSize.s11,
                        ),
                      ),
                      SizedBox(width: AppSize.s12),
                      Text(
                        'Reply',
                        style: getRegularStyle(
                          color: ColorManager.kGrey4,
                          fontSize: FontSize.s11,
                        ),
                      )
                    ]),
                    SizedBox(height: AppSize.s8),
                    _buildCommentReplies(count: 10),
                  ],
                ),
              ),
              Icon(
                Icons.favorite_outline,
              ),
            ]));
  }

  _buildCommentReplies({required int count}) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDash(),
            SizedBox(width: AppSize.s12),
            Text(
              'View $count more replies',
              style: getRegularStyle(
                color: ColorManager.kGrey4,
                fontSize: 8,
              ),
            ),
            SizedBox(width: AppSize.s12),
            _buildDash(),
          ]),
    );
  }

  _buildDash({double? width}) {
    return Container(
      width: width ?? 24,
      height: 1,
      decoration: BoxDecoration(
        color: ColorManager.kGrey3,
      ),
    );
  }
}
