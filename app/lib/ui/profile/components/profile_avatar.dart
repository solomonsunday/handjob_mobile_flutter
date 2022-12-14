import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import '../profile_view.dart';
import 'profile_edit_icon.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: AppSize.s100,
          height: AppSize.s100,
          decoration: BoxDecoration(
            color: ColorManager.kSecondaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: ColorManager.kWhiteColor,
            ),
          ),
        ),
        Positioned(
          child: ProfileEditIcon(),
          right: -4,
          bottom: 8,
        )
      ],
    );
  }
}
