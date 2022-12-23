import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/post/post_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.nonReactive(
      viewModelBuilder: () => PostViewModel(),
      builder: (_, model, child) => Scaffold(
        appBar: Navbar(
          leadingIcon: Icon(
            Icons.arrow_back,
            color: ColorManager.kDarkColor,
          ),
          onTap: model.navigateBack,
          title: 'Create Post',
          fontsize: FontSize.s16,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: AppSize.s8),
                PostFormView(),
                SizedBox(height: AppSize.s40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostFormView extends ViewModelWidget<PostViewModel> {
  const PostFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, PostViewModel model) {
    return Container(
      padding: EdgeInsets.all(AppSize.s24),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: AppSize.s24,
                  backgroundColor: ColorManager.kDarkColor,
                ),
                SizedBox(width: AppSize.s12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Demola',
                      style: getBoldStyle(
                        color: ColorManager.kDarkColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    SizedBox(height: AppSize.s4),
                    DefaultDropDownField(
                      hint: 'Anyone',
                      value: 'Anyone',
                      dropdownItems: ['Text', 'Video', 'Anyone'],
                      onChanged: model.handlePostType,
                      buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorManager.kDarkColor,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.s16),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.s20),
          InputField(
            label: 'Title',
            hintText: 'Enter a title...',
          ),
          SizedBox(height: AppSize.s24),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ColorManager.kDarkColor,
              ),
              borderRadius: BorderRadius.circular(AppSize.s16),
            ),
            child: Column(
              children: [
                Textarea(
                  label: 'Body',
                  hintText: 'Start writing here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: ColorManager.kDarkColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: ColorManager.kGrey1,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Add:',
                      style: TextStyle(
                        fontSize: FontSize.s12,
                      ),
                    ),
                    SizedBox(width: AppSize.s12),
                    Icon(
                      Icons.photo,
                      color: ColorManager.kDarkColor,
                      size: AppSize.s24,
                    ),
                    SizedBox(width: AppSize.s12),
                    Icon(
                      Icons.videocam,
                      color: ColorManager.kDarkColor,
                      size: AppSize.s24,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.s12),
          DefaultButton(
            onPressed: () {},
            title: 'Post',
            busy: false,
          ),
        ],
      ),
    );
  }
}
