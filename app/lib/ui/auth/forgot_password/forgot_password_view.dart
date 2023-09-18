import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/auth/forgot_password/forgot_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import 'forgot_password_view_model.dart';

@FormView(fields: [FormTextField(name: 'email')])
class ForgotPasswordView extends StatelessWidget with $ForgotPasswordView {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onViewModelReady: syncFormWithViewModel,
      onDispose: (_) => disposeForm(),
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
                  Image.asset('assets/images/1.png'),
                  const SizedBox(height: AppSize.s12),
                  Text(
                    'Forgot Password?',
                    style: getMediumStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  Text(
                    'Enter your email to recover your password',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Email',
                    controller: emailController,
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
                    onPressed: model.isBusy ? null : model.recoverPassword,
                    title: 'Recover password',
                    busy: model.isBusy,
                    buttonBgColor: const Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w400,
                    disabled: model.isBusy,
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
                              fontSize: FontSize.s12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => model.navigateToLogin(),
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
