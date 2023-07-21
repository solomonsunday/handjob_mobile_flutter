import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/services/post.service.dart';
import 'package:handjob_mobile/ui/main/post/post_view_model.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:handjob_mobile/utils/humanize_date.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/font_styles.dart' as FontSize;

import '../../models/post.model.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../contact/contact_view_model.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.post,
    this.inPosition = false,
    this.onImageClick,
    this.onAuthorClick,
  }) : super(key: key);

  final Post post;
  final bool inPosition;
  final Function()? onImageClick;
  final Function(String)? onAuthorClick;

  Widget getBody(String data) {
    return Html(
      data: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeCardViewModel>.reactive(
        viewModelBuilder: () => HomeCardViewModel(),
        builder: (context, model, _) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xffd9d9d9),
                        ),
                        child: post.author?.imageUrl == null
                            ? Image.asset(
                                'assets/images/logo.jpeg',
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/logo.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/logo.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                imageUrl: post.author?.imageUrl ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  onAuthorClick!(post.author?.id ?? ""),
                              child: Text(
                                // ayojohnsonToc (2052:4272)
                                '${post.author?.firstName} ${post.author?.otherName ?? ""} ${post.author?.lastName}',
                                style: getMediumStyle(
                                  fontSize: 14,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Wrap(
                              children: [
                                FittedBox(
                                  child: Text(
                                    // hairstylistLsQ (2052:4273)
                                    '${post.author?.profession ?? post.author?.services ?? post.author?.accountType}',
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: getMediumStyle(
                                      fontSize: 11,
                                      color: const Color(0xff555555),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      if (post.author?.id == model.currentUser?.id)
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            print('value selected: $value');
                            switch (value) {
                              case DELETE:
                                model.deletePost(post.id!);
                                break;
                              default:
                                break;
                            }
                          },
                          itemBuilder: (BuildContext bc) {
                            return [
                              PopupMenuItem(
                                height: 10,
                                child: Text(
                                  'Delete Post',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.kRed,
                                    fontSize: 14,
                                  ),
                                ),
                                value: DELETE,
                              )
                            ];
                          },
                          child: const Icon(
                            Icons.more_vert,
                            size: AppSize.s24,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                GestureDetector(
                  onTap: onImageClick,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: AppPadding.p16,
                      //   ),
                      //   child: Text(
                      //     post.title ?? "",
                      //     style: getSemiBoldStyle(
                      //       color: ColorManager.kDarkColor,
                      //       fontSize: FontSize.FontSize.s14,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p8,
                        ),
                        child: getBody(post.body ?? ""),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      // hoursago1MG (2439:4362)
                      humanizeDate(fromIsoToDateTime(post.createdAt!)),
                      style: getMediumStyle(
                        fontSize: 10,
                        color: const Color(0xff000000),
                      ),
                    ),
                    const SizedBox(width: AppSize.s12),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    GestureDetector(
                      onTap: onImageClick,
                      child: (post.postMedia ?? []).isEmpty
                          ? Container()
                          : post.postMedia![0]['mediaType'] == VIDEO
                              ? SizedBox(
                                  height: 320,
                                  width: double.infinity,
                                  child: DefaultVideoPlayer(
                                    inPosition: inPosition,
                                    url: post.postMedia![0]['url'],
                                    videoType: VideoType.NETWORK,
                                  ),
                                )
                              : SizedBox(
                                  height: 320,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/logo.jpeg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/logo.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    imageUrl: post.postMedia![0]['url'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                    ),
                    const SizedBox(
                      height: AppSize.s8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p24,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => model.onLikePost(post),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  model.isLiked || (post.liked ?? false)
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: ColorManager.kDarkColor,
                                ),
                                Text(
                                  '${post.likes} like${post.likes! > 1 ? 's' : ''}',
                                  style: getRegularStyle(
                                    color: ColorManager.kPrimary400Color,
                                    fontSize: FontSize.FontSize.s11,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          GestureDetector(
                            onTap: onImageClick,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  MdiIcons.chat,
                                  color: ColorManager.kDarkColor,
                                ),
                                Text(
                                  '${post.commentCount} comment${post.commentCount! > 1 ? 's' : ''}',
                                  style: getRegularStyle(
                                    color: ColorManager.kPrimary400Color,
                                    fontSize: FontSize.FontSize.s11,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: () {
                              String linkToShare =
                                  'https://handjobs-web.vercel.app/post/${post.id}';

                              Share.share(
                                'View this post $linkToShare',
                                subject: '${post.title}',
                              );
                            },
                            child: const Icon(
                              Icons.share,
                              color: ColorManager.kDarkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // model.busy(LIKE_POST)
                    //     ? const LinearProgressIndicator(
                    //         valueColor: AlwaysStoppedAnimation(
                    //           ColorManager.kDarkColor,
                    //         ),
                    //         backgroundColor: ColorManager.kBackgroundolor,
                    //       )
                    //     : Container(),
                    const Divider()
                  ],
                ),
                if (model.busy(DELETE_POST))
                  const LinearProgressIndicator(
                    color: ColorManager.kGrey1,
                    valueColor:
                        AlwaysStoppedAnimation(ColorManager.kPrimaryColor),
                  ),
              ],
            ),
          );
        });
  }
}

const String LIKE_POST = "LIKE_POST";
const String DELETE_POST = 'DELETE_POST';

class HomeCardViewModel extends BaseViewModel {
  final _postService = locator<PostService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  Future onLikePost(Post post) async {
    _isLiked = !_isLiked;

    post.likes = _isLiked ? (post.likes ?? 0) + 1 : (post.likes ?? 0) - 1;
    notifyListeners();
    setBusyForObject(LIKE_POST, true);

    try {
      if (_isLiked) {
        await _postService.likePost(post.id!);
      } else {
        await _postService.disLikePost(post.id!);
      }
      post = await _postService.getPost(post.id!);
      Fluttertoast.showToast(
          msg: 'You just ${_isLiked ? 'liked' : 'unliked'} a post');
    } on DioError catch (e) {
      print('error liking: ${e.response?.data ?? "error unknown"}');
      post.likes = (post.likes ?? 0) - 1;
      _isLiked = false;
      Fluttertoast.showToast(
          msg: 'Unable to like post. please try again later');
    } finally {
      setBusyForObject(LIKE_POST, false);
      notifyListeners();
    }
  }

  deletePost(String id) {
    runBusyFuture(deletePostRequest(id), busyObject: DELETE_POST);
  }

  deletePostRequest(String id) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Do you really want to delete this post?",
    );
    if (!response!.confirmed) return;

    try {
      await _postService.deletePost(id);
      Fluttertoast.showToast(
        msg: 'Post has been deleted!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      notifyListeners();
    }
  }
}
