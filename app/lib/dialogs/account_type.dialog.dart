import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';
import 'package:ui_package/widgets/button/button.dart';

const String CUSTOMER = "CUSTOMER";
const String ARTISAN = "ARTISAN";
const String CREATE_ACCOUNT = "CREATE_ACCOUNT";

class AccountTypeDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const AccountTypeDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSize.s24),
            Text(
              'Kindly select one of the following',
              style: getRegularStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s14,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                completer(DialogResponse(confirmed: true, data: CUSTOMER));
              },
              title: 'Customer',
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              leadingIcon: Icons.person_outline,
              leadingIconColor: ColorManager.kPrimaryColor,
              buttonType: ButtonType.outline,
            ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                completer(DialogResponse(confirmed: true, data: ARTISAN));
              },
              title: 'Artisan',
              buttonBgColor: ColorManager.kSecondaryColor,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.bold,
              leadingIcon: Icons.handyman_sharp,
              leadingIconColor: ColorManager.kWhiteColor,
              buttonType: ButtonType.fill,
            ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                completer(
                    DialogResponse(confirmed: true, data: CREATE_ACCOUNT));
              },
              title: 'Create Account',
              fontWeight: FontWeightManager.regular,
              fontSize: AppSize.s12,
              borderRadius: AppSize.s12,
            ),
            const SizedBox(height: AppSize.s24),
          ],
        ),
      ),
    );
  }
}
