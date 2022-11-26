import 'package:flutter/material.dart';

import '../../ui_package.dart';

class OnboardingViewThree extends StatelessWidget {
  OnboardingViewThree({
    Key? key,
    required this.onFinishPressed,
    required this.onSkipPressed,
  }) : super(key: key);

  Function() onSkipPressed;
  Function() onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
      decoration: BoxDecoration(color: ColorManager.kWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onSkipPressed,
                child: Text(
                  AppString.skip,
                  style: getBoldStyle(
                      color: ColorManager.kDarkCharcoal,
                      fontSize: FontSize.s16),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ColorManager.kGrey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppString.manage,
                    style: getBoldStyle(
                        color: ColorManager.kPrimaryColor,
                        fontSize: FontSize.s24)),
                const SizedBox(height: 10),
                Text(
                  AppString.onBoardSub3,
                  style: getMediumStyle(
                      color: ColorManager.kGrey1, fontSize: FontSize.s16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
