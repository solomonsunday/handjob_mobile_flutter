import 'package:flutter/material.dart';

import '../../ui_package.dart';

class OnboardIndicator extends StatelessWidget {
  const OnboardIndicator({
    Key? key,
    required this.activeIndex,
  }) : super(key: key);

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: activeIndex == 0 ? AppSize.s16 : AppSize.s8,
            height: AppSize.s8,
            decoration: BoxDecoration(
              color: activeIndex == 0 ? Colors.black : ColorManager.kLightGray,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
          ),
          const SizedBox(width: AppSize.s4),
          Container(
            width: activeIndex == 1 ? AppSize.s16 : AppSize.s8,
            height: AppSize.s8,
            decoration: BoxDecoration(
              color: activeIndex == 1 ? Colors.black : ColorManager.kLightGray,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
          ),
          const SizedBox(width: AppSize.s4),
          Container(
            width: activeIndex == 2 ? AppSize.s16 : AppSize.s8,
            height: AppSize.s8,
            decoration: BoxDecoration(
              color: activeIndex == 2 ? Colors.black : ColorManager.kLightGray,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
          ),
        ],
      ),
    );
  }
}
