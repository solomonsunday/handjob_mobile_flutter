import 'package:flutter/material.dart';
import 'package:ui_package/utils/colors.dart';

import '../../utils/values_manager.dart';
// : super(key: key) this.buttonBgColor??= ColorManager.kPrimaryColor, this.buttonTextColor ??= ColorManager.kWhiteColor this.leadingIconColor ??= ColorManager.kPrimaryColor  this.trailingIconColor??=ColorManager.kPrimaryColor ;

enum ButtonType { fill, outline, text }

enum BorderRadiusType { none, left, right }

class DefaultButton extends StatelessWidget {
  final double borderRadius;
  final double fontSize;
  final String title;
  final bool busy;
  final Border? border;
  // final bool fullwidth;
  Function() onPressed;
  final Color buttonBgColor;
  final Color? buttonTextColor;
  final Color? leadingIconColor;
  final Color? trailingIconColor;
  final FontWeight fontWeight;
  final ButtonType? buttonType;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double trailingIconSpace;
  final double leadingIconSpace;
  final double? paddingHeight;
  final double? paddingWidth;
  final BorderRadiusType borderRadiusType;

  final bool? disabled;

  DefaultButton({
    Key? key,
    this.borderRadius = 8.0,
    this.border,
    this.fontSize = 14.0,
    this.trailingIconSpace = 4.0,
    this.leadingIconSpace = 4.0,
    this.fontWeight = FontWeight.w500,
    required this.onPressed,
    this.buttonBgColor = ColorManager.kPrimaryColor,
    this.buttonTextColor = ColorManager.kWhiteColor,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingIconColor = ColorManager.kPrimaryColor,
    this.trailingIconColor = ColorManager.kPrimaryColor,
    this.busy = false,
    this.buttonType = ButtonType.fill,
    this.borderRadiusType = BorderRadiusType.none,
    this.disabled = false,
    this.paddingHeight,
    this.paddingWidth,
  });

  Color getBackgroundColor() {
    if (buttonType == ButtonType.outline) {
      return buttonTextColor != null
          ? buttonTextColor!
          : ColorManager.kWhiteColor;
    } else if (buttonType == ButtonType.fill) {
      return buttonBgColor;
    } else {
      return Colors.transparent;
    }
  }

  Color getColor() {
    if (buttonType == ButtonType.fill) {
      return buttonTextColor != null
          ? buttonTextColor!
          : ColorManager.kWhiteColor;
    } else if (buttonType == ButtonType.outline) {
      return buttonBgColor;
    } else {
      return buttonTextColor != null ? buttonTextColor! : buttonBgColor;
    }
  }

  Border constructBorder() {
    if (border != null) {
      return border!;
    }
    if (buttonType == ButtonType.outline) {
      return Border.all(
        color: getColor(),
        width: 1,
      );
    } else {
      return Border.all(
        color: Colors.transparent,
        width: 0,
      );
    }
  }

  BorderRadius _constructBorderRadius(BorderRadiusType type) {
    switch (type) {
      case BorderRadiusType.left:
        return BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.zero,
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.zero,
        );
      case BorderRadiusType.right:
        return BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.zero,
          bottomRight: Radius.circular(borderRadius),
        );
      default:
        return BorderRadius.circular(borderRadius);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _color = getColor();
    final _bgColor = getBackgroundColor();
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHeight ?? 24.0,
          vertical: paddingWidth ?? 23.0,
        ),
        decoration: BoxDecoration(
          borderRadius: _constructBorderRadius(borderRadiusType),
          color: disabled! ? ColorManager.kLightGray : _bgColor,
          border: constructBorder(),
        ),
        child:
            // busy
            //     ? const SizedBox(
            //         width: AppSize.s16,
            //         height: AppSize.s16,
            //         child: PosCircularProgress(),
            //       )
            // :
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Icon(
                leadingIcon,
                color: leadingIconColor,
              ),
            if (leadingIcon != null) SizedBox(width: leadingIconSpace),
            Text(
              title,
              style: TextStyle(
                  color: _color, fontSize: fontSize, fontWeight: fontWeight),
            ),
            if (trailingIcon != null) SizedBox(width: trailingIconSpace),
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: trailingIconColor,
              ),
            if (busy) const SizedBox(width: AppSize.s20),
            if (busy)
              const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: ColorManager.kWhiteColor,
                  strokeWidth: 2,
                ),
              )
          ],
        ),
      ),
    );
  }
}
