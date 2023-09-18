import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/ui/auth/signup/artisan/artisan_signup_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../utils/contants.dart';
import '../customer/customer_signup_view_model.dart';
import 'artisan_signup_view_model.dart';

const List<String> accountTypes = ["Job Seeker", "Employer"];

@FormView(fields: [
  FormTextField(name: 'firstname'),
  FormTextField(name: 'lastname'),
  FormTextField(name: 'username'),
  FormTextField(name: 'email'),
  FormTextField(name: 'phone'),
  FormTextField(name: 'password'),
  FormTextField(name: 'retypePassword'),
])
class ArtisanSignupView extends StatelessWidget with $ArtisanSignupView {
  ArtisanSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArtisanSignupViewModel>.reactive(
      viewModelBuilder: () => ArtisanSignupViewModel(),
      onViewModelReady: (model) async {
        syncFormWithViewModel(model);
        await model.fetchProfessionTypes();
      },
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ColorManager.kWhiteColor,
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p24),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: AppSize.s24),
                Image.asset('assets/images/1.png'),
                const SizedBox(height: AppSize.s12),
                Text(
                  "Create a secure account",
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s16,
                  ),
                ),
                const SizedBox(height: AppSize.s24),
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
                  formError: model.phoneValidationMessage,
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
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                if (model.tosError != null)
                  Text(model.tosError ?? "",
                      style: getRegularStyle(
                        color: ColorManager.kRed,
                        fontSize: 12.0,
                      )),
                const SizedBox(height: AppSize.s12),
                DefaultDropDownField(
                  hint: 'Profession',
                  value: model.selectedProfession,
                  dropdownItems: model.professions,
                  onChanged: model.handleSelectedProfession,
                  buttonDecoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorManager.kDarkColor,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.s12),
                  ),
                  buttonWidth: MediaQuery.of(context).size.width,
                  dropdownWidth: MediaQuery.of(context).size.width,
                  buttonHeight: AppSize.s48,
                ),
                if (model.busy(PROFESSION_TYPES))
                  const LinearProgressIndicator(
                    color: ColorManager.kPrimaryColor,
                  ),
                const SizedBox(height: AppSize.s24),
                DefaultCheckBox(
                  value: model.tos,
                  onChanged: model.handleTos,
                  richText: RichText(
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => model.showTermOfServiceDialog(),
                        ),
                      ],
                    ),
                    softWrap: true,
                    maxLines: 10,
                  ),
                ),
                const SizedBox(height: AppSize.s24),
                DefaultButton(
                  onPressed: model.tos &&
                          model.selectedProfession != null &&
                          model.formIsValid &&
                          !model.hasPhoneValidationMessage &&
                          !model.busy(DEFAULT_AUTH)
                      ? model.register
                      : () {},
                  title: 'Sign Up',
                  busy: model.isBusy,
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s12,
                  disabled: !model.tos ||
                      !model.formIsValid ||
                      model.hasPhoneValidationMessage ||
                      model.selectedProfession == null ||
                      model.busy(DEFAULT_AUTH),
                ),
                // Text('form valid: ${model.formIsValid}, tos: ${model.tos}'),
                const SizedBox(height: AppSize.s48),
                DefaultButton(
                  onPressed: () {},
                  title: "Sign up with your Google account",
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s12,
                  leadingIcon: SvgPicture.asset(
                    'assets/images/google_icon.svg',
                  ),
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
  }
}
