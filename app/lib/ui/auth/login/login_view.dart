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
        backgroundColor: ColorManager.kGreyBtn,
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
                        'assets/images/jb.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    InputField(
                      hintText: 'Username',
                      onChanged: model.handleEmail,
                      fillColor: ColorManager.kWhiteColor,
                      keyBoardType: TextInputType.emailAddress,
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
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: AppSize.s24,
                          color: ColorManager.kDarkCharcoal,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot your password',
                            style: getMediumStyle(
                              color: ColorManager.kDarkCharcoal,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s12),
                    DefaultButton(
                      onPressed: model.login,
                      title: 'Sign In',
                      busy: model.isBusy,
                    ),
                    const SizedBox(height: AppSize.s12),
                    Row(
                      children: [
                        Text(
                          "Don't have an account yet",
                          style: getMediumStyle(
                            color: ColorManager.kDarkCharcoal,
                            fontSize: FontSize.s14,
                          ),
                        ),
                        const SizedBox(width: AppSize.s20),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SIGN UP',
                              style: getMediumStyle(
                                color: ColorManager.kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s12),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            onPressed: () {},
                            title: 'Facebook',
                            leadingIcon: MdiIcons.facebook,
                            leadingIconColor: ColorManager.kWhiteColor,
                            buttonBgColor: ColorManager.kFacebookColor,
                          ),
                        ),
                        const SizedBox(width: AppSize.s8),
                        Expanded(
                          child: DefaultButton(
                            onPressed: () {},
                            title: 'Google',
                            leadingIcon: MdiIcons.google,
                            leadingIconColor: ColorManager.kWhiteColor,
                            buttonBgColor: ColorManager.kGoogleColor,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
