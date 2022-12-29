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
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                  Positioned(
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
                  ProfileAvatar(),
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
            '${model.currentUser!.firstName} ${model.currentUser!.lastName}',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Text(
            '${model.currentUser?.profession ?? model.currentUser!.accountType}',
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
