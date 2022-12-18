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
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/gallery/1.png',
              ),
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
