import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

import '../profile_view_model.dart';

class ProfilePortfolioGallery extends ViewModelWidget<ProfileViewModel> {
  const ProfilePortfolioGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Container(
      height: 390,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ColorManager.kSecondaryColor,
        ),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(
          9,
          (index) => Container(
            decoration: BoxDecoration(
              color: ColorManager.kSecondaryColor,
              borderRadius: BorderRadius.circular(AppSize.s4),
            ),
          ),
        ),
      ),
    );
  }
}
