import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class ProfileEditIcon extends StatelessWidget {
  const ProfileEditIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorManager.kSecondaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: ColorManager.kWhiteColor,
        ),
      ),
      child: const Icon(
        Icons.edit,
        color: ColorManager.kWhiteColor,
        size: AppSize.s16,
      ),
    );
  }
}
