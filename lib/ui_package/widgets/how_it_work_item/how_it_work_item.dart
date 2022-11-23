import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/values_manager.dart';

class HowItWorksItem extends StatelessWidget {
  const HowItWorksItem({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);
  final String content;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s12),
      child: Container(
        constraints:
            const BoxConstraints(minHeight: 100, minWidth: double.infinity),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       SvgPicture.asset(
            //         'assets/images/HowItWorksIcon.svg',
            //       ),
            //       Expanded(child: Container())
            //     ],
            //   ),
            // ),
            // Stack(
            //   clipBehavior: Clip.none,
            //   children: [
            //     SvgPicture.asset(
            //       'assets/images/HowItWorksIcon.svg',
            //     )
            //   ],
            // ),
            const SizedBox(width: AppSize.s20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: FontSize.s18,
                      color: ColorManager.kHowItWorksTitle,
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Text(content,
                      style: const TextStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kTurquoiseDarkColor,
                      ),
                      textAlign: TextAlign.left)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
