import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../rating/rating.dart';
import 'profile_avatar.dart';
import 'profile_edit_icon.dart';

class ProfileHeader extends ViewModelWidget<ProfileViewModel> {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
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
                    child: Image.network(
                      model.currentUser?.imageUrl ??
                          "https://i.picsum.photos/id/866/200/200.jpg?hmac=i0ngmQOk9dRZEzhEosP31m_vQnKBQ9C19TBP1CGoIUA",
                      fit: BoxFit.cover,
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
                    onTap: () => model.uploadProfileAvatar(),
                    child: ProfileAvatar(
                      imgUrl: model.currentUser?.imageUrl,
                      busy: model.busy(PROFILE_AVATAR_UPLOAD),
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
                  Rating(),
                  Text(
                    '79 connections',
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
            '${model.currentUser?.firstName} ${model.currentUser?.lastName}',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Text(
            '${model.currentUser?.profession ?? model.currentUser?.accountType}',
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
