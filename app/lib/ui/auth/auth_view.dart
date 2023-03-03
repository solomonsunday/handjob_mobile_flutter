import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/ui/auth/auth_view.form.dart';
import 'package:handjob_mobile/ui/auth/auth_view_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class AuthView extends StatelessWidget with $AuthView {
  AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      onModelReady: listenToFormUpdated,
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
                  const SizedBox(height: AppSize.s24),
                  Image.asset('assets/images/favicon.png'),
                  const SizedBox(height: AppSize.s24),
                  Text(
                    'Login to your account',
                    style: getMediumStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s24),
                  InputField(
                    hintText: 'Username',
                    controller: emailController,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: ColorManager.kWhiteColor,
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Password',
                    controller: passwordController,
                    fillColor: ColorManager.kWhiteColor,
                    obscureText: model.visibility,
                    suffixIcon: GestureDetector(
                      onTap: model.toggleVisibility,
                      child: Icon(
                        model.visibility
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: AppSize.s24,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultCheckBox(
                        value: false,
                        onChanged: (value) {},
                        checkColor: ColorManager.kWhiteColor,
                        activeColor: ColorManager.kDarkColor,
                        richText: Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            'keep me logged in',
                            style: getRegularStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s11,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: model.navigateToForgotPassword,
                        child: Text(
                          'Forgot password?',
                          style: getRegularStyle(
                            color: ColorManager.kGrey3,
                            fontSize: FontSize.s11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s40),
                  // if (model.errorMessage.isNotEmpty)
                  //   Text(
                  //     '${model.errorMessage}',
                  //     style: getMediumStyle(
                  //       color: ColorManager.kRed,
                  //       fontSize: FontSize.s14,
                  //     ),
                  //   ),
                  DefaultButton(
                    onPressed: model.login,
                    title: 'Login',
                    busy: model.isBusy,
                    buttonBgColor: ColorManager.kDarkColor,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: AppSize.s40),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: ColorManager.kDarkColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSize.s12),
                      Text(
                        'OR',
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      SizedBox(width: AppSize.s12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: ColorManager.kDarkColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s40),
                  Column(
                    children: [
                      SizedBox(
                        child: DefaultButton(
                          paddingHeight: AppPadding.p20,
                          onPressed: () {},
                          title: 'Via Facebook',
                          fontSize: FontSize.s12,
                          leadingIcon: SvgPicture.asset(
                            'assets/images/facebook_icon.svg',
                          ),
                          leadingIconColor: ColorManager.kDarkColor,
                          buttonBgColor: ColorManager.kWhiteColor,
                          border: Border.all(
                            width: 1,
                            color: ColorManager.kDarkColor,
                          ),
                          borderRadius: AppSize.s12,
                          buttonTextColor: ColorManager.kDarkColor,
                        ),
                      ),
                      const SizedBox(height: AppSize.s8),
                      SizedBox(
                        child: DefaultButton(
                          paddingHeight: 22,
                          onPressed: () {},
                          title: 'Via Google',
                          fontSize: FontSize.s12,
                          leadingIcon: SvgPicture.asset(
                            'assets/images/google_icon.svg',
                          ),
                          leadingIconColor: ColorManager.kDarkColor,
                          buttonBgColor: ColorManager.kWhiteColor,
                          border: Border.all(
                            width: 1,
                            color: ColorManager.kDarkColor,
                          ),
                          borderRadius: AppSize.s12,
                          buttonTextColor: ColorManager.kDarkColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s32),
                  RichText(
                    text: TextSpan(
                        text: "Don't have an account",
                        style: getRegularStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s11),
                        children: [
                          TextSpan(
                            text: ' SIGN UP ',
                            style: getMediumStyle(
                              color: ColorManager.kSecondaryColor,
                              fontSize: FontSize.s12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => model.showDialog(),
                          ),
                          TextSpan(text: ' here')
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
