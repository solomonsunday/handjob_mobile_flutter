import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class PosCircularProgress extends StatelessWidget {
  const PosCircularProgress({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation(color ?? ColorManager.kWhiteColor),
    );
  }
}
