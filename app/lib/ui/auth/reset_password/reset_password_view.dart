import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/auth/auth_view_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import 'reset_password_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'password'),
  FormTextField(name: 'confirmPassword'),
])
class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ColorManager.kWhiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: AppSize.s12),
                  Image.asset('assets/images/favicon.png'),
                  const SizedBox(height: AppSize.s12),
                  Text(
                    'Reset Password',
                    style: getMediumStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  Text(
                    'Enter your new password',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Enter password',
                    // controller: pa,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: ColorManager.kWhiteColor,
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Confirm password',
                    // controller: model.emailController,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: ColorManager.kWhiteColor,
                  ),

                  const SizedBox(height: AppSize.s40),
                  if (model.hasError)
                    Text(
                      '${model.modelError}',
                      style: getMediumStyle(
                        color: ColorManager.kRed,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  DefaultButton(
                    onPressed: model.recoverPassword,
                    title: 'Reset password',
                    busy: model.isBusy,
                    buttonBgColor: ColorManager.kDarkColor,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: AppSize.s12),

                  RichText(
                    text: TextSpan(
                        text: "Back to",
                        style: getRegularStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s11),
                        children: [
                          TextSpan(
                            text: ' LOG IN',
                            style: getMediumStyle(
                                color: ColorManager.kSecondaryColor,
                                fontSize: FontSize.s12),
                          ),
                        ]),
                  ),
                  // Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
