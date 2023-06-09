import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import 'customer_signup_view.form.dart';
import 'customer_signup_view_model.dart';

const List<String> accountTypes = ["Job Seeker", "Employer"];

@FormView(fields: [
  FormTextField(name: 'firstname'),
  FormTextField(name: 'lastname'),
  FormTextField(name: 'email'),
  FormTextField(name: 'phone'),
  FormTextField(name: 'password'),
  FormTextField(name: 'retypePassword'),
])
class CustomerSignupView extends StatelessWidget with $CustomerSignupView {
  CustomerSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSignupViewModel>.reactive(
      viewModelBuilder: () => CustomerSignupViewModel(),
      onViewModelReady: (model) {
        syncFormWithViewModel(model);
      },
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) {
        print('isloading: ${model.busy(DEFAULT_AUTH)}');
        return Scaffold(
          backgroundColor: ColorManager.kWhiteColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p24),
              child: SingleChildScrollView(
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
                      hintText: 'Firstname',
                      controller: firstnameController,
                      fillColor: ColorManager.kWhiteColor,
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSize.s12),
                    InputField(
                      hintText: 'Lastname',
                      controller: lastnameController,
                      fillColor: ColorManager.kWhiteColor,
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSize.s12),
                    InputField(
                      hintText: 'Email',
                      controller: emailController,
                      fillColor: ColorManager.kWhiteColor,
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSize.s12),
                    InputField(
                      hintText: 'Phone No.',
                      controller: phoneController,
                      fillColor: ColorManager.kWhiteColor,
                      keyBoardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSize.s12),
                    InputField(
                      hintText: 'Password',
                      controller: passwordController,
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
                    InputField(
                      hintText: 'Re-type Password',
                      controller: retypePasswordController,
                      obscureText: model.retypePasswordVisibility,
                      suffixIcon: GestureDetector(
                        onTap: model.toggleRetypePasswordVisibility,
                        child: Icon(
                          model.retypePasswordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: AppSize.s24,
                          color: ColorManager.kDarkCharcoal,
                        ),
                      ),
                      formError: model.retypePasswordValidationMessage,
                    ),
                    // const SizedBox(height: AppSize.s24),
                    // DefaultCheckBox(
                    //   value: false,
                    //   onChanged: (value) {},
                    //   richText: Expanded(
                    //     child: RichText(
                    //       textAlign: TextAlign.left,
                    //       text: TextSpan(
                    //         style: getRegularStyle(
                    //           color: ColorManager.kDarkCharcoal,
                    //           fontSize: FontSize.s9,
                    //         ),
                    //         text:
                    //             "By proceeding to create your account, you are agreeing to our  \n",
                    //         children: [
                    //           TextSpan(
                    //             text: 'Terms & Conditions',
                    //             style: getBoldStyle(
                    //               color: ColorManager.kDarkColor,
                    //               fontSize: FontSize.s9,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       softWrap: true,
                    //       maxLines: 10,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: AppSize.s24),
                    DefaultButton(
                      onPressed: model.formIsValid
                          ? model.register
                          : () {
                              print('not valid');
                            },
                      title: 'Sign Up',
                      busy: model.busy(DEFAULT_AUTH),
                      fontWeight: FontWeightManager.regular,
                      fontSize: FontSize.s12,
                      disabled: !model.formIsValid,
                    ),
                    const SizedBox(height: AppSize.s24),
                    DefaultButton(
                      onPressed: () async {
                        await model.signUpWithGoogleAuth();
                      },
                      title: "Sign up with your Google account",
                      fontWeight: FontWeightManager.regular,
                      fontSize: FontSize.s12,
                      leadingIcon: SvgPicture.asset(
                        'assets/images/google_icon.svg',
                      ),
                      buttonType: ButtonType.outline,
                      borderRadius: AppSize.s12,
                      paddingHeight: 10,
                      busy: model.busy(GOOGLE_AUTH),
                      busyColor: ColorManager.kSecondaryColor,
                    ),
                    const SizedBox(height: AppSize.s48),
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
                        InkWell(
                          onTap: model.navigateToLogin,
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
        );
      },
    );
  }
}
