import 'package:flutter/material.dart';

import '../../ui_package.dart';

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
    this.primaryColor,
    this.backgroundColor,
  });

  final Color? primaryColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: backgroundColor ?? ColorManager.kDarkCharcoal,
      valueColor: AlwaysStoppedAnimation(
        primaryColor ?? ColorManager.kPrimaryColor,
      ),
    );
  }
}
