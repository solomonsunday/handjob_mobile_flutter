import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/text_styles.dart';
import '../../utils/values_manager.dart';

class ShowDialogContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  final String? title;
  final Color? color;
  final BorderRadius? borderRadius;
  final Function() onPressed;
  const ShowDialogContainer({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.height,
    this.title,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        child: SizedBox(
          height: height ?? 500,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.cancel_rounded),
                    color: ColorManager.kChineseSilver,
                  )),
              Text(
                title ?? '',
                style: getSemiBoldStyle(
                    color: ColorManager.kDarkCharcoal, fontSize: FontSize.s18),
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              Container(
                width: double.infinity,
                height: AppSize.s1_5,
                color: ColorManager.kAzureishWhite,
              ),
              child,
            ],
          ),
        ));
  }
}
