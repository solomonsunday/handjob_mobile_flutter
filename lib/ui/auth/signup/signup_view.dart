import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/auth/login/login_view_model.dart';
import 'package:handjob_mobile/ui/auth/signup/signup_view_model.dart';
import 'package:handjob_mobile/ui_package/utils/colors.dart';
import 'package:handjob_mobile/ui_package/utils/font_styles.dart';
import 'package:handjob_mobile/ui_package/utils/text_styles.dart';
import 'package:handjob_mobile/ui_package/utils/values_manager.dart';
import 'package:handjob_mobile/ui_package/widgets/buttons/button.dart';
import 'package:handjob_mobile/ui_package/widgets/input/input.dart';
import 'package:handjob_mobile/ui_package/widgets/keyboardAware/keyboard_aware.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

const List<String> accountTypes = ["Job Seeker", "Employer"];

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ColorManager.kGreyBtn,
        body: SafeArea(
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
                  const SizedBox(height: AppSize.s12),
                  DropdownButton2<String>(
                    onChanged: (value) => model.handleAccountType(value),
                    items: accountTypes
                        .map(
                          (type) => DropdownMenuItem<String>(
                            child: Text(
                              type,
                              style: getMediumStyle(
                                color: ColorManager.kDarkCharcoal,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            value: type,
                          ),
                        )
                        .toList(),
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
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: AppSize.s24,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  InputField(
                    hintText: 'Confirm Password',
                    onChanged: model.handleConfirmPassword,
                    obscureText: model.confirmPasswordVisibility,
                    suffixIcon: GestureDetector(
                      onTap: model.toggleConfirmPasswordVisibility,
                      child: Icon(
                        model.confirmPasswordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: AppSize.s24,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: model.setTos(model.tos ?? false),
                        child: Text(
                          'Terms & Conditions',
                          style: getMediumStyle(
                            color: ColorManager.kDarkCharcoal,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: model.tos,
                        onChanged: (value) => model.setTos(value),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s12),
                  JBButton(
                    onPressed: model.register,
                    title: 'Sign Up',
                    busy: model.isBusy,
                  ),
                  const SizedBox(height: AppSize.s12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: getMediumStyle(
                          color: ColorManager.kDarkCharcoal,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      const SizedBox(height: AppSize.s20),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'LOGIN',
                            style: getMediumStyle(
                              color: ColorManager.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s12),
                ]),
          ),
        ),
      ),
    );
  }
}
