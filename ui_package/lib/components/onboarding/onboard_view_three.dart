import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui_package.dart';
import 'onboard_indicator.dart';

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
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.s40,
        horizontal: AppPadding.p8,
      ),
      decoration: const BoxDecoration(color: ColorManager.kWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p8,
              horizontal: AppPadding.p16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/favicon.png'),
                GestureDetector(
                  onTap: onSkipPressed,
                  child: Text(
                    AppString.skip,
                    style: getRegularStyle(
                        color: ColorManager.kDarkColor, fontSize: FontSize.s14),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 80),
          SvgPicture.asset(
            'assets/images/people_search.svg',
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p24,
              vertical: AppPadding.p16,
            ),
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Connect With \nArtisans",
                    style: getBoldStyle(
                      color: Colors.black,
                      fontSize: FontSize.s24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Connect with skilled and experienced artisans from all over.',
                  style: getMediumStyle(
                    color: Colors.black,
                    fontSize: FontSize.s12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const OnboardIndicator(activeIndex: 2),
                const SizedBox(
                  height: 40,
                ),
                DefaultButton(
                  onPressed: onFinishPressed,
                  title: 'Get Started',
                  buttonTextColor: ColorManager.kWhiteColor,
                  buttonBgColor: Colors.black,
                  borderRadius: AppSize.s12,
                  trailingIcon: Icons.arrow_forward,
                  trailingIconColor: ColorManager.kWhiteColor,
                )
              ],
            ),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}
