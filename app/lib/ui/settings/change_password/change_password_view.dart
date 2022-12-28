import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import './change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.nonReactive(
        viewModelBuilder: () => ChangePasswordViewModel(),
        builder: (context, model, child) {
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
            body: ListView(children: [
              SizedBox(height: AppSize.s40),
              Text('Create a new password that is at least 8 characters long'),
              SizedBox(height: AppSize.s40),
              InputField(
                label: 'Enter your current password',
                hintText: 'Current password',
                keyBoardType: TextInputType.text,
              ),
              SizedBox(height: AppSize.s40),
              InputField(
                label: 'Enter your new password',
                hintText: 'New password',
                keyBoardType: TextInputType.text,
              ),
              SizedBox(height: AppSize.s40),
              InputField(
                label: 'Re-enter your new password',
                hintText: 'New password',
                keyBoardType: TextInputType.text,
              ),
              SizedBox(height: AppSize.s40),
              DefaultButton(
                onPressed: () {},
                title: 'Change password',
                disabled: true,
                busy: false,
              ),
            ]),
          );
        });
  }
}
