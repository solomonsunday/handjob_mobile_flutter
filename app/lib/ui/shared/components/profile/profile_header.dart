import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/user.model.dart';
import '../rating/rating.dart';
import 'profile_avatar.dart';
import 'profile_edit_icon.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.currentUser,
    this.uploadProfileAvatar,
    required this.busy,
    required this.connectionCount,
    required this.rating,
  }) : super(key: key);
  final User? currentUser;
  final VoidCallback? uploadProfileAvatar;
  final bool busy;
  final int connectionCount;
  final double rating;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: ColorManager.kSecondaryColor,
                    ),
                    child: currentUser == null
                        ? Image.asset(
                            'assets/images/logo.jpeg',
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: ColorManager.kSecondaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              return Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/logo.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            imageUrl: currentUser?.imageUrl ??
                                "https://i.picsum.photos/id/866/200/200.jpg?hmac=i0ngmQOk9dRZEzhEosP31m_vQnKBQ9C19TBP1CGoIUA",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                  const Positioned(
                    top: AppSize.s12,
                    right: AppSize.s20,
                    child: ProfileEditIcon(),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -40,
              left: 10,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: uploadProfileAvatar == null
                        ? () {}
                        : () => uploadProfileAvatar!(),
                    child: ProfileAvatar(
                      imgUrl: currentUser?.imageUrl,
                      busy: busy,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -40,
              left: 124,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Rating(
                    value: rating,
                  ),
                  Text(
                    '$connectionCount connections',
                    style: getBoldStyle(
                      color: ColorManager.kSecondaryColor,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s48),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Text(
            '${currentUser?.firstName} ${currentUser?.lastName}',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Text(
            '${currentUser?.profession ?? currentUser?.accountType}',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
        ),
      ],
    );
  }
}
