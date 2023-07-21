import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';
import 'package:ui_package/widgets/button/button.dart';

import '../app/app.locator.dart';

const String CUSTOMER = "CUSTOMER";
const String ARTISAN = "ARTISAN";
const String CREATE_ACCOUNT = "CREATE_ACCOUNT";
const String LOG_IN = 'LOG_IN';

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
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  widget.completer(DialogResponse(confirmed: true));
                },
                child: const Icon(Icons.close),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSize.s24),
                Text(
                  'Kindly select account type',
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
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAccountType = CUSTOMER;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 24),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorManager.kDarkCharcoal,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: _selectedAccountType == CUSTOMER
                                ? ColorManager.kSecondaryColor
                                : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: _selectedAccountType == CUSTOMER
                                    ? ColorManager.kWhiteColor
                                    : ColorManager.kDarkColor,
                              ),
                              Text(
                                'Customer',
                                style: getMediumStyle(
                                  color: _selectedAccountType == CUSTOMER
                                      ? ColorManager.kWhiteColor
                                      : ColorManager.kDarkColor,
                                  fontSize: FontSize.s14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s24),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAccountType = ARTISAN;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 24),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorManager.kDarkCharcoal,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: _selectedAccountType == ARTISAN
                                ? ColorManager.kSecondaryColor
                                : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.handyman_sharp,
                                color: _selectedAccountType == ARTISAN
                                    ? ColorManager.kWhiteColor
                                    : ColorManager.kDarkColor,
                              ),
                              Text(
                                'Artisan',
                                style: getMediumStyle(
                                  color: _selectedAccountType == ARTISAN
                                      ? ColorManager.kWhiteColor
                                      : ColorManager.kDarkColor,
                                  fontSize: FontSize.s14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // DefaultButton(
                //   onPressed: () {
                //     setState(() {
                //       _selectedAccountType = CUSTOMER;
                //     });
                //   },
                //   title: 'Customer',
                //   buttonTextColor: _selectedAccountType == CUSTOMER
                //       ? ColorManager.kWhiteColor
                //       : ColorManager.kDarkColor,
                //   fontSize: FontSize.s14,
                //   fontWeight: FontWeightManager.regular,
                //   leadingIcon: Icon(
                //     Icons.person_outline,
                //     color: _selectedAccountType == CUSTOMER
                //         ? ColorManager.kWhiteColor
                //         : ColorManager.kDarkColor,
                //   ),
                //   leadingIconColor: ColorManager.kPrimaryColor,
                //   buttonBgColor: _selectedAccountType == CUSTOMER
                //       ? ColorManager.kSecondaryColor
                //       : Colors.transparent,
                //   border: _selectedAccountType == CUSTOMER
                //       ? null
                //       : Border.all(
                //           width: 1,
                //           color: ColorManager.kDarkCharcoal,
                //         ),
                // ),
                // const SizedBox(height: AppSize.s24),
                // DefaultButton(
                //   onPressed: () {
                //     setState(() {
                //       _selectedAccountType = ARTISAN;
                //     });
                //   },
                //   title: 'Artisan',
                //   buttonTextColor: _selectedAccountType == ARTISAN
                //       ? ColorManager.kWhiteColor
                //       : ColorManager.kDarkColor,
                //   fontSize: FontSize.s14,
                //   fontWeight: FontWeightManager.bold,
                //   leadingIcon: Icon(
                //     Icons.handyman_sharp,
                //     size: AppSize.s24,
                //     color: _selectedAccountType == ARTISAN
                //         ? ColorManager.kWhiteColor
                //         : ColorManager.kDarkColor,
                //   ),
                //   leadingIconColor: ColorManager.kWhiteColor,
                //   buttonType: ButtonType.fill,
                //   buttonBgColor: _selectedAccountType == ARTISAN
                //       ? ColorManager.kSecondaryColor
                //       : Colors.transparent,
                //   border: _selectedAccountType == ARTISAN
                //       ? null
                //       : Border.all(
                //           width: 1,
                //           color: ColorManager.kDarkCharcoal,
                //         ),
                // ),
                const SizedBox(height: AppSize.s24),
                DefaultButton(
                  onPressed: _selectedAccountType == null
                      ? null
                      : () {
                          setState(() {
                            _showError = null;
                          });
                          widget.completer(DialogResponse(
                              confirmed: true, data: _selectedAccountType));
                        },
                  title: 'Continue',
                  fontWeight: FontWeightManager.regular,
                  fontSize: AppSize.s14,
                  borderRadius: AppSize.s12,
                  disabled: _selectedAccountType == null,
                ),
                const SizedBox(height: AppSize.s12),
                const Divider(
                  color: ColorManager.kDarkCharcoal,
                ),
                const SizedBox(height: AppSize.s12),
                RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12),
                      children: [
                        TextSpan(
                          text: ' Login ',
                          style: getMediumStyle(
                            color: ColorManager.kSecondaryColor,
                            fontSize: FontSize.s14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.completer(DialogResponse(
                                confirmed: true,
                                data: LOG_IN,
                              ));
                              final _navigationService =
                                  locator<NavigationService>();
                              _navigationService.replaceWithAuthView();
                            },
                        ),
                        const TextSpan(text: ' here')
                      ]),
                ),
                // Text('Already have an account?'),
                // DefaultButton(
                //   onPressed: () => widget.completer(DialogResponse(
                //     confirmed: true,
                //     data: LOG_IN,
                //   )),
                //   title: 'Sign In',
                //   fontWeight: FontWeightManager.regular,
                //   fontSize: AppSize.s16,
                //   borderRadius: AppSize.s12,
                //   buttonType: ButtonType.text,
                //   buttonTextColor: ColorManager.kDarkCharcoal,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
