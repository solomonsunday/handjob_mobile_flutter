import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class ProfileContactSheet extends StatelessWidget {
  const ProfileContactSheet({
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
              Icon(
                Icons.phone,
                color: ColorManager.kSecondaryColor,
              ),
              SizedBox(width: AppSize.s12),
              Text('Contact Information'),
            ],
          ),
          SizedBox(height: AppSize.s24),
          InputField(
            label: 'Email address',
            hintText: 'johndemola@gmail.com',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          InputField(
            label: 'Phone number',
            hintText: 'Enter phone number',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          Row(
            children: [
              Expanded(
                child: InputField(
                  label: 'State',
                  hintText: 'Enter',
                ),
              ),
              SizedBox(width: AppSize.s12),
              Expanded(
                child: DatePicker(
                  onSelected: (p0) {},
                  label: 'LGA',
                  hintText: 'Enter',
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s12),
          Textarea(
            label: 'Address',
            hintText: 'Enter',
            fillColor: ColorManager.kWhiteColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(height: AppSize.s24),
          DefaultButton(onPressed: () {}, title: 'Save changes')
        ],
      ),
    );
  }
}
