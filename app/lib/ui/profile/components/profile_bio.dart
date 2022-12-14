import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../profile_view_model.dart';

class ProfileBio extends ViewModelWidget<ProfileViewModel> {
  const ProfileBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
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
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
          style: getRegularStyle(
            color: ColorManager.kDarkColor,
            fontSize: FontSize.s12,
          ),
        ),
      ]),
    );
  }
}
