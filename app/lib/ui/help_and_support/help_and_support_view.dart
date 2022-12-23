import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/help_and_support/help_and_support_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpAndSupportViewModel>.nonReactive(
      viewModelBuilder: () => HelpAndSupportViewModel(),
      builder: (_, model, child) => Scaffold(
        appBar: Navbar(
          title: 'Help and support',
          leadingIcon: GestureDetector(
            onTap: model.goBack,
            child: Icon(
              Icons.arrow_back,
              color: ColorManager.kDarkColor,
            ),
          ),
          titleStyle: getBoldStyle(
            color: ColorManager.kDarkColor,
            fontSize: FontSize.s16,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'How can we help you?',
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: AppSize.s32),
                Text(
                  'This feature is optimized to help you with any issue you might be having. You will be redirected to send an email  to our supports team when you click the button below.',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
                SizedBox(height: AppSize.s24),
                InputField(
                  label: 'Enter email',
                  hintText: 'e.g example@gmail.com',
                  keyBoardType: TextInputType.emailAddress,
                ),
                SizedBox(height: AppSize.s40),
                DefaultButton(
                  onPressed: () {},
                  title: 'Proceed to email',
                  disabled: true,
                  busy: false,
                ),
              ]),
        ),
      ),
    );
  }
}
