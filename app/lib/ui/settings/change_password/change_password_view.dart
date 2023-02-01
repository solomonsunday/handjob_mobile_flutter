import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/settings/change_password/change_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import './change_password_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'oldPassword'),
  FormTextField(name: 'newPassword'),
  FormTextField(name: 'confirmPassword')
])
class ChangePasswordView extends StatelessWidget with $ChangePasswordView {
  ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
        viewModelBuilder: () => ChangePasswordViewModel(),
        onModelReady: (model) {
          listenToFormUpdated(model);
        },
        onDispose: (model) => disposeForm(),
        builder: (context, model, child) {
          print('form valid: ${model.isFormValid}');
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: model.goBack,
                child: const Icon(
                  Icons.arrow_back,
                  color: ColorManager.kDarkColor,
                ),
              ),
              title: Text(
                'Change Password',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              backgroundColor: ColorManager.kWhiteColor,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppSize.s16),
              child: ListView(children: [
                SizedBox(height: AppSize.s40),
                Text(
                    'Create a new password that is at least 8 characters long'),
                SizedBox(height: AppSize.s40),
                InputField(
                  label: 'Enter your current password',
                  hintText: 'Current password',
                  keyBoardType: TextInputType.text,
                  controller: oldPasswordController,
                  focusnode: oldPasswordFocusNode,
                ),
                const SizedBox(height: AppSize.s40),
                InputField(
                  label: 'Enter your new password',
                  hintText: 'New password',
                  keyBoardType: TextInputType.text,
                  controller: newPasswordController,
                  focusnode: newPasswordFocusNode,
                ),
                const SizedBox(height: AppSize.s40),
                InputField(
                  label: 'Re-enter your new password',
                  hintText: 'New password',
                  keyBoardType: TextInputType.text,
                  controller: confirmPasswordController,
                  focusnode: confirmPasswordFocusNode,
                ),
                const SizedBox(height: AppSize.s40),
                DefaultButton(
                  onPressed: model.isBusy || !model.isFormValid
                      ? null
                      : model.changePassword,
                  title: 'Change password',
                  disabled: !model.isFormValid,
                  busy: model.isBusy,
                ),
              ]),
            ),
          );
        });
  }
}
