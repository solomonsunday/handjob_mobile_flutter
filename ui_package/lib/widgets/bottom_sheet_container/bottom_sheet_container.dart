import 'package:flutter/material.dart';

import '../../ui_package.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onClose;
  final bool showClose;
  const BottomSheetContainer({
    Key? key,
    required this.child,
    this.color,
    this.margin,
    this.padding,
    this.borderRadius,
    this.onClose,
    this.showClose = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppPadding.p24),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          child,
          showClose
              ? Positioned(
                  top: AppSize.s8,
                  right: AppSize.s8,
                  child: GestureDetector(
                    onTap: () => onClose!(),
                    child: const Icon(
                      Icons.close,
                      size: AppSize.s24,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
