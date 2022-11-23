import 'package:flutter/material.dart';

import '../../utils/app_layout.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/text_styles.dart';
import '../../utils/values_manager.dart';

class CardWidget extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final String? amount;
  final Color? bgColor;
  final Color? titleColor;
  final Color? amountColor;
  final bool noRightMargin;

  const CardWidget(
      {Key? key,
      this.imgUrl,
      this.title,
      this.amount,
      this.bgColor,
      this.titleColor,
      this.amountColor,
      this.noRightMargin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p30),
      margin: noRightMargin ? null : EdgeInsets.only(right: 16),
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        color: bgColor ?? ColorManager.kWhiteColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 5),
            color: Color.fromRGBO(0, 0, 0, 0.08),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SvgPicture.asset(imgUrl!),
          Image.asset(imgUrl!),
          Text(title!,
              style: getLightStyle(
                color: titleColor ?? ColorManager.kNavNonActiveColor,
              )),

          Text(amount!,
              style: getThickStyle(
                  color: amountColor ?? ColorManager.kPrimaryColor,
                  fontSize: FontSize.s32)),
        ],
      ),
    );
  }
}
