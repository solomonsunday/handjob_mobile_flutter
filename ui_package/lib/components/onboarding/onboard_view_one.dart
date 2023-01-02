import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ui_package.dart';
import 'onboard_indicator.dart';

class OnboardingViewOne extends StatelessWidget {
  OnboardingViewOne({
    Key? key,
    required this.onSkipPressed,
    required this.onNextPressed,
  }) : super(key: key);

  Function() onSkipPressed;
  Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.s40,
        horizontal: AppPadding.p8,
      ),
      decoration: const BoxDecoration(color: ColorManager.kWhiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 80),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/request_instance_service.svg',
              fit: BoxFit.cover,
            ),
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
                    AppString.requestInstantService,
                    style: getBoldStyle(
                      color: Colors.black,
                      fontSize: FontSize.s24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Conveniently make requests to hire skilled workers for instant services.',
                  style: getMediumStyle(
                    color: Colors.black,
                    fontSize: FontSize.s12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                OnboardIndicator(activeIndex: 0),
                const SizedBox(
                  height: 40,
                ),
                DefaultButton(
                  onPressed: onNextPressed,
                  title: 'Next',
                  buttonBgColor: Colors.black,
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
