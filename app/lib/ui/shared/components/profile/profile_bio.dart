import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ProfileBio extends StatelessWidget {
  const ProfileBio({
    Key? key,
    required this.bio,
  }) : super(key: key);

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Bio',
          style: getBoldStyle(
            color: ColorManager.kDarkColor,
            fontSize: FontSize.s14,
          ),
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          bio,
          style: getRegularStyle(
            color: ColorManager.kDarkColor,
            fontSize: FontSize.s12,
          ),
        ),
      ]),
    );
  }
}
