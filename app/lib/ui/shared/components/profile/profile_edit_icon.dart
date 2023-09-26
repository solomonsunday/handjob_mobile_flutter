import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class ProfileEditIcon extends StatelessWidget {
  const ProfileEditIcon({
    Key? key,
    this.onTap,
    this.padding = 4,
  }) : super(key: key);
  final double padding;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
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
      ),
    );
  }
}
