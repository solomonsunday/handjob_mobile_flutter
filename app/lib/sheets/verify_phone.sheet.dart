import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class VerifyPhoneSheet extends StatelessWidget {
  const VerifyPhoneSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verify phone number'),
            ],
          ),
          SizedBox(height: AppSize.s24),
          Text('Enter the code that was sent to your phone number'),
          SizedBox(height: AppSize.s12),
          InputField(
            hintText: 'Enter verification code',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s24),
          DefaultButton(onPressed: () {}, title: 'Verify'),
        ],
      ),
    );
  }
}
