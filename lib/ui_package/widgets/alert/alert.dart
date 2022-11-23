import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/values_manager.dart';

import '../../utils/text_styles.dart';

class Alert {
  static Widget primary({
    String text = "",
    IconData? icon,
    Color textColor = ColorManager.kWhiteColor,
    Color iconColor = ColorManager.kWhiteColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p8, horizontal: AppPadding.p10),
      decoration: const BoxDecoration(
        color: ColorManager.kPrimaryDarkColor,
      ),
      child: Row(children: [
        Icon(Icons.warning_rounded, color: iconColor, size: AppSize.s12),
        const SizedBox(width: AppSize.s12),
        Flexible(
          child: Text(
            text,
            style: getRegularStyle(
              color: textColor,
              fontSize: FontSize.s14,
            ),
          ),
        )
      ]),
    );
  }
}
