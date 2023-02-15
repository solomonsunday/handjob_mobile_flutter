import 'package:flutter/material.dart';

import '../../ui_package.dart';

class ProfileActionHeader extends StatelessWidget {
  const ProfileActionHeader({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: AppSize.s24,
                  color: ColorManager.kDarkColor,
                ),
                const SizedBox(width: AppSize.s4),
                Text(
                  title,
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                )
              ],
            ),
            if (onTap != null)
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.add_circle_outline,
                  size: AppSize.s24,
                  color: ColorManager.kDarkColor,
                ),
              )
          ],
        ),
        const Divider(
          thickness: 1,
          color: ColorManager.kGrey,
        )
      ],
    );
  }
}
