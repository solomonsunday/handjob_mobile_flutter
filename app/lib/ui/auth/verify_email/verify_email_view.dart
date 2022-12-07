import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

import 'verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>.reactive(
      viewModelBuilder: () => VerifyEmailViewModel(),
      builder: (context, model, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify your e-mail',
                style: getSemiBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(height: AppSize.s56),
              SvgPicture.asset(
                'assets/images/verify_email_icon.svg',
                width: 143,
                height: 143,
              ),
              const SizedBox(height: AppSize.s24),
              Text(
                'We just sent an email to the address you provided. Please check your email and click on the link provided to verify your address',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s56),
              DefaultButton(
                onPressed: model.showSuccessDialog,
                title: 'Resend Verification E-mail',
                buttonBgColor: ColorManager.kDarkColor,
                borderRadius: AppSize.s12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
