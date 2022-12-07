import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/ui/auth/login/login_view_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'customer_signup_view_model.dart';

const List<String> accountTypes = ["Job Seeker", "Employer"];

class CustomerSignupView extends StatelessWidget {
  const CustomerSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSignupViewModel>.reactive(
      viewModelBuilder: () => CustomerSignupViewModel(),
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
                    "Create a secure account",
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Username',
                    onChanged: model.handleEmail,
                    fillColor: ColorManager.kWhiteColor,
                    keyBoardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Email',
                    onChanged: model.handleEmail,
                    fillColor: ColorManager.kWhiteColor,
                    keyBoardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Phone No.',
                    onChanged: model.handlePhone,
                    fillColor: ColorManager.kWhiteColor,
                    keyBoardType: TextInputType.phone,
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Password',
                    onChanged: model.handlePassword,
                    obscureText: model.passwordVisibility,
                    suffixIcon: GestureDetector(
                      onTap: model.togglePasswordVisibility,
                      child: Icon(
                        model.passwordVisibility
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: AppSize.s24,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  const SizedBox(height: AppSize.s24),
                  DefaultCheckBox(
                    value: false,
                    onChanged: (value) {},
                    richText: Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: getRegularStyle(
                            color: ColorManager.kDarkCharcoal,
                            fontSize: FontSize.s9,
                          ),
                          text:
                              "By proceeding to create your account, you are agreeing to our  \n",
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: getBoldStyle(
                                color: ColorManager.kDarkColor,
                                fontSize: FontSize.s9,
                              ),
                            ),
                          ],
                        ),
                        softWrap: true,
                        maxLines: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s24),
                  DefaultButton(
                    onPressed: model.register,
                    title: 'Sign Up',
                    busy: model.isBusy,
                  ),
                  const SizedBox(height: AppSize.s24),
                  DefaultButton(
                    onPressed: () {},
                    title: "Sign up with your Google account",
                    leadingIcon: MdiIcons.google,
                    buttonType: ButtonType.outline,
                    borderRadius: AppSize.s12,
                    paddingHeight: 10,
                  ),
                  const SizedBox(height: AppSize.s24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Already have an account?",
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s11,
                        ),
                      ),
                      const SizedBox(width: AppSize.s4),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "LOG IN",
                          style: getBoldStyle(
                            color: ColorManager.kSecondaryColor,
                            fontSize: FontSize.s11,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSize.s4),
                      Text(
                        "here",
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s11,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
