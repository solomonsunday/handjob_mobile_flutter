import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';
import 'package:ui_package/widgets/button/button.dart';

class AccountCreatedDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const AccountCreatedDialog(
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
            SvgPicture.asset(
              'assets/images/check_done.svg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSize.s24),
            Text(
              "You're all set!",
              style: getRegularStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s16,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            DefaultButton(
              onPressed: () {
                completer(DialogResponse(confirmed: true));
              },
              title: 'Proceed To Home',
              fontWeight: FontWeightManager.regular,
              fontSize: AppSize.s12,
              borderRadius: AppSize.s12,
              trailingIcon: Icons.arrow_forward,
              trailingIconColor: ColorManager.kDarkColor,
            ),
            const SizedBox(height: AppSize.s24),
          ],
        ),
      ),
    );
  }
}
