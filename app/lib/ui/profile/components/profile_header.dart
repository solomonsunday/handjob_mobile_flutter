import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import 'profile_avatar.dart';
import 'profile_edit_icon.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: ProfileAvatar(),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s48),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Text(
            'John Demola',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Text(
            'Professional electrician',
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
