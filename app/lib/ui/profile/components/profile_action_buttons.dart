import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
      child: Wrap(
        spacing: AppSize.s8,
        runSpacing: AppSize.s8,
        direction: Axis.horizontal,
        children: [
          DefaultButton(
            onPressed: () {},
            paddingHeight: 10,
            paddingWidth: 10,
            buttonType: ButtonType.outline,
            title: 'Add phone',
            trailingIcon: Icons.phone,
            trailingIconColor: ColorManager.kSecondaryColor,
          ),
          DefaultButton(
            onPressed: () {},
            paddingHeight: 10,
            paddingWidth: 10,
            buttonType: ButtonType.outline,
            title: 'Enter location',
            trailingIcon: Icons.pin_drop_outlined,
            trailingIconColor: ColorManager.kSecondaryColor,
          ),
          DefaultButton(
            onPressed: () {},
            paddingHeight: 10,
            paddingWidth: 10,
            buttonType: ButtonType.fill,
            buttonBgColor: ColorManager.kPrimaryColor,
            buttonTextColor: ColorManager.kWhiteColor,
            title: 'Send connection request',
            trailingIcon: Icons.groups_rounded,
            trailingIconColor: ColorManager.kSecondaryColor,
          ),
          DefaultButton(
            onPressed: () {},
            paddingHeight: 10,
            paddingWidth: 10,
            title: 'Message',
            buttonType: ButtonType.outline,
            trailingIcon: Icons.chat,
            trailingIconColor: ColorManager.kSecondaryColor,
          ),
        ],
      ),
    );
  }
}
