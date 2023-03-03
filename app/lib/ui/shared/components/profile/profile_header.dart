import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../dialogs/account_type.dialog.dart';
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
    this.isView = false,
  }) : super(key: key);
  final User? currentUser;
  final VoidCallback? uploadProfileAvatar;
  final bool busy;
  final int connectionCount;
  final double rating;
  final bool isView;

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
                    child: currentUser == null ||
                            currentUser?.imageUrl == "" ||
                            currentUser?.imageUrl == null
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
                            imageUrl: currentUser!.imageUrl!,
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
                  if (!isView)
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
                        isView: isView),
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
            '${currentUser?.role == CUSTOMER ? "Customer" : currentUser?.profession ?? currentUser?.accountType}',
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
