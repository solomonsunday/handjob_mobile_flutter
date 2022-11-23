import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/text_styles.dart';
import '../../utils/values_manager.dart';

class BottomStickyNote extends StatelessWidget {
  const BottomStickyNote({
    Key? key,
    this.text = "",
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p24),
      decoration: const BoxDecoration(
        color: ColorManager.kLightGrayishOrange,
      ),
      child: Column(
        children: [
          SvgPicture.asset('assets/images/bulb.svg'),
          const SizedBox(
            height: AppSize.s12,
          ),
          Text(
            text,
            style: style ??
                getBoldStyle(
                  color: ColorManager.kGrey1,
                  fontSize: FontSize.s14,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
