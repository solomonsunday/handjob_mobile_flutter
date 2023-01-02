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

class AccountTypeDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const AccountTypeDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  State<AccountTypeDialog> createState() => _AccountTypeDialogState();
}

class _AccountTypeDialogState extends State<AccountTypeDialog> {
  String? _selectedAccountType;
  String? _showError;
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
            if (_showError != null)
              Text(
                '$_showError',
                style: getRegularStyle(
                  color: ColorManager.kRed,
                  fontSize: FontSize.s14,
                ),
              ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                setState(() {
                  _selectedAccountType = CUSTOMER;
                });
              },
              title: 'Customer',
              buttonTextColor: _selectedAccountType == CUSTOMER
                  ? ColorManager.kWhiteColor
                  : ColorManager.kDarkColor,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              leadingIcon: Icon(
                Icons.person_outline,
                color: _selectedAccountType == CUSTOMER
                    ? ColorManager.kWhiteColor
                    : ColorManager.kDarkColor,
              ),
              leadingIconColor: ColorManager.kPrimaryColor,
              buttonBgColor: _selectedAccountType == CUSTOMER
                  ? ColorManager.kSecondaryColor
                  : Colors.transparent,
              border: _selectedAccountType == CUSTOMER
                  ? null
                  : Border.all(
                      width: 1,
                      color: ColorManager.kDarkCharcoal,
                    ),
            ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                setState(() {
                  _selectedAccountType = ARTISAN;
                });
              },
              title: 'Artisan',
              buttonTextColor: _selectedAccountType == ARTISAN
                  ? ColorManager.kWhiteColor
                  : ColorManager.kDarkColor,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.bold,
              leadingIcon: Icon(
                Icons.handyman_sharp,
                size: AppSize.s24,
                color: _selectedAccountType == ARTISAN
                    ? ColorManager.kWhiteColor
                    : ColorManager.kDarkColor,
              ),
              leadingIconColor: ColorManager.kWhiteColor,
              buttonType: ButtonType.fill,
              buttonBgColor: _selectedAccountType == ARTISAN
                  ? ColorManager.kSecondaryColor
                  : Colors.transparent,
              border: _selectedAccountType == ARTISAN
                  ? null
                  : Border.all(
                      width: 1,
                      color: ColorManager.kDarkCharcoal,
                    ),
            ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                if (_selectedAccountType == null) {
                  setState(() {
                    _showError = "Please choose an account type";
                  });
                  return;
                }
                setState(() {
                  _showError = null;
                });
                widget.completer(DialogResponse(
                    confirmed: true, data: _selectedAccountType));
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
