import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/post/post_view.form.dart';
import 'package:handjob_mobile/ui/main/post/post_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

@FormView(fields: [
  FormTextField(name: 'title'),
  FormTextField(name: 'body'),
])
class PostView extends StatelessWidget with $PostView {
  PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.nonReactive(
      viewModelBuilder: () => PostViewModel(),
      onViewModelReady: (model) => listenToFormUpdated(model),
      onDispose: (model) => disposeForm(),
      builder: (_, model, child) => Scaffold(
        appBar: Navbar(
          leadingIcon: const Icon(
            Icons.arrow_back,
            color: ColorManager.kDarkColor,
          ),
          onTap: model.navigateBack,
          title: 'Create Post',
          fontsize: FontSize.s16,
          color: ColorManager.kWhiteColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSize.s8),
                PostFormView(
                  titleController: titleController,
                  bodyController: bodyController,
                  titleFocusnode: titleFocusNode,
                  bodyFocusnode: bodyFocusNode,
                ),
                const SizedBox(height: AppSize.s40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostFormView extends ViewModelWidget<PostViewModel> {
  const PostFormView({
    Key? key,
    required this.titleController,
    required this.bodyController,
    required this.titleFocusnode,
    required this.bodyFocusnode,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyController;
  final FocusNode titleFocusnode;
  final FocusNode bodyFocusnode;

  @override
  Widget build(BuildContext context, PostViewModel model) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s24),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: model.currentUser?.imageUrl == null
                      ? const CircleAvatar(
                          radius: AppSize.s24,
                          backgroundImage:
                              AssetImage('assets/images/logo.png'))
                      : CachedNetworkImage(
                          placeholder: (context, url) => const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) {
                            return Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          imageUrl: model.currentUser?.imageUrl ??
                              "https://i.picsum.photos/id/866/200/200.jpg?hmac=i0ngmQOk9dRZEzhEosP31m_vQnKBQ9C19TBP1CGoIUA",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: AppSize.s12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.currentUser?.firstName} ${model.currentUser?.lastName}',
                      style: getBoldStyle(
                        color: ColorManager.kDarkColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    const SizedBox(height: AppSize.s4),
                    DefaultDropDownField(
                      hint: 'Media Type',
                      value: model.mediaType,
                      dropdownItems: model.mediaTypes,
                      onChanged: model.handleMediaType,
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
          const SizedBox(height: AppSize.s20),
          // InputField(
          //   label: 'Title',
          //   hintText: 'Enter a title...',
          //   controller: titleController,
          //   focusnode: titleFocusnode,
          //   formError:
          //       titleFocusnode.hasFocus && model.hasTitleValidationMessage
          //           ? model.titleValidationMessage
          //           : null,
          // ),
          const SizedBox(height: AppSize.s24),
          Container(
            padding: const EdgeInsets.all(12),
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: ColorManager.kDarkColor,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: ColorManager.kGrey1,
                    ),
                  ),
                  controller: bodyController,
                  focusnode: bodyFocusnode,
                  maxLength: 1500,
                  formError:
                      bodyFocusnode.hasFocus && model.hasBodyValidationMessage
                          ? model.bodyValidationMessage
                          : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: AppSize.s16),
                model.selectedFile == null
                    ? Container()
                    : model.mediaType == IMAGE
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Image.file(model.selectedFile!),
                          )
                        : model.mediaType == VIDEO
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: DefaultVideoPlayer(
                                  url: model.selectedFile!.path,
                                  videoType: VideoType.FILE,
                                ),
                                // child: Text(
                                //   'No preview available',
                                //   style: getSemiBoldStyle(
                                //     color: ColorManager.kDarkColor,
                                //     fontSize: FontSize.s14,
                                //   ),
                                // ),
                              )
                            : Container(),
                if (model.errorMessage != null)
                  Text(
                    '${model.errorMessage}',
                    style: getRegularStyle(
                      color: ColorManager.kRed,
                      fontSize: FontSize.s12,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Add:',
                      style: TextStyle(
                        fontSize: FontSize.s12,
                      ),
                    ),
                    const SizedBox(width: AppSize.s12),
                    GestureDetector(
                      onTap: model.mediaType != IMAGE
                          ? null
                          : model.handleImageChange,
                      child: Icon(
                        Icons.photo,
                        color: model.mediaType == IMAGE
                            ? ColorManager.kDarkColor
                            : ColorManager.kBackgroundolor,
                        size: AppSize.s24,
                      ),
                    ),
                    const SizedBox(width: AppSize.s12),
                    GestureDetector(
                      onTap: model.mediaType != VIDEO
                          ? null
                          : model.handleVideoChange,
                      child: Icon(
                        Icons.videocam,
                        color: model.mediaType == VIDEO
                            ? ColorManager.kDarkColor
                            : ColorManager.kBackgroundolor,
                        size: AppSize.s24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${bodyController.text.length}/1500'),
            ],
          ),
          const SizedBox(height: AppSize.s12),
          DefaultButton(
            onPressed:
                !model.isFormValid || model.isBusy ? null : model.createPost,
            title: 'Post',
            busy: model.isBusy,
            disabled: !model.isFormValid || model.isBusy,
          ),
        ],
      ),
    );
  }
}
