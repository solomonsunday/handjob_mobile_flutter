import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

import '../profile_view_model.dart';

class ProfilePortfolioGallery extends StatelessWidget {
  const ProfilePortfolioGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      padding: EdgeInsets.zero,
      children: List.generate(
        9,
        (index) => ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s4),
          child: Image.asset(
            'assets/images/gallery/${1 + index}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
