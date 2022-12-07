import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/auth/login/login_view_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                  SizedBox(
                    height: AppSize.s100,
                    child: Image.asset(
                      'assets/images/favicon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  Text(
                    'Login to your account',
                    style: getMediumStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Username',
                    onChanged: model.handleEmail,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: ColorManager.kWhiteColor,
                  ),
                  SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Password',
                    onChanged: model.handlePassword,
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
                        onTap: () {},
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
                  DefaultButton(
                    onPressed: model.login,
                    title: 'Login',
                    busy: model.isBusy,
                    buttonBgColor: ColorManager.kDarkColor,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: AppSize.s12),
                  Row(
                    children: [],
                  ),
                  const SizedBox(height: AppSize.s12),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: DefaultButton(
                            onPressed: () {},
                            title: 'Via Facebook',
                            fontSize: FontSize.s12,
                            leadingIcon: Icons.facebook_sharp,
                            leadingIconColor: ColorManager.kDarkColor,
                            buttonBgColor: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 2,
                              color: ColorManager.kDarkColor,
                            ),
                            borderRadius: AppSize.s12,
                            buttonTextColor: ColorManager.kDarkColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSize.s8),
                      Expanded(
                        child: SizedBox(
                          child: DefaultButton(
                            onPressed: () {},
                            title: 'Via Google',
                            fontSize: FontSize.s12,
                            leadingIcon: MdiIcons.google,
                            leadingIconColor: ColorManager.kDarkColor,
                            buttonBgColor: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 2,
                              color: ColorManager.kDarkColor,
                            ),
                            borderRadius: AppSize.s12,
                            buttonTextColor: ColorManager.kDarkColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Don't have an account",
                        style: getRegularStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s11),
                        children: [
                          TextSpan(
                            text: 'SIGN UP',
                            style: getMediumStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: FontSize.s12),
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
