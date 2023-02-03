import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

import '../../models/post.model.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.post,
    this.onImageClick,
  }) : super(key: key);

  final Post post;
  final Function()? onImageClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
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
                    color: Color(0xffd9d9d9),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    imageUrl: post.author?.imageUrl ??
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // ayojohnsonToc (2052:4272)
                        '${post.author?.firstName} ${post.author?.otherName ?? ""} ${post.author?.lastName}',
                        style: getMediumStyle(
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                      SizedBox(
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
                                color: Color(0xff555555),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      // Container(
                      //   // autogroups118FzN (CfxGqzCFuy6wvrVzxXs118)
                      //   width: 50,
                      //   height: 10,
                      //   child: Image.network(
                      //     post.author?.imageUrl ??
                      //         'https://t3.ftcdn.net/jpg/03/35/91/90/360_F_335919003_TH0ZtHZZ5QGT34n1NcQXzRGvz4Pthg11.jpg',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSize.s12),
                Text(
                  // hoursago1MG (2439:4362)
                  '11 hours ago',
                  style: getMediumStyle(
                    fontSize: 10,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p24,
            ),
            child: Text(
              post.title ?? "",
              style: getRegularStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          // stop here...
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s12,
              ),
              GestureDetector(
                onTap: onImageClick,
                child: Container(
                  height: 320,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    imageUrl: (post.postMedia ?? []).isNotEmpty
                        ? post.postMedia![0]
                        : 'https://picsum.photos/660/200',
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
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            post.liked!
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: ColorManager.kDarkColor,
                          ),
                          Text(
                            '${post.likes} likes',
                            style: getRegularStyle(
                              color: ColorManager.kPrimary400Color,
                              fontSize: FontSize.s11,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: AppSize.s12,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.chat_bubble,
                            color: ColorManager.kDarkColor,
                          ),
                          Text(
                            '${post.commentCount} messages',
                            style: getRegularStyle(
                              color: ColorManager.kPrimary400Color,
                              fontSize: FontSize.s11,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.share,
                        color: ColorManager.kDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider()
            ],
          ),
        ],
      ),
    );
  }
}
