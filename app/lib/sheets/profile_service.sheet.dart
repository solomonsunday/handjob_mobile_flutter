import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class ProfileServiceSheet extends StatelessWidget {
  const ProfileServiceSheet({
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
                Icons.tag,
                color: ColorManager.kSecondaryColor,
              ),
              SizedBox(width: AppSize.s12),
              Text('Services'),
            ],
          ),
          SizedBox(height: AppSize.s24),
          Text('Add up to five services'),
          SizedBox(height: AppSize.s24),
          // DefaultDropDownField(
          //   hint: 'Select service',
          //   value: 'service',
          //   dropdownItems: ['Hello', 'Wolrd'],
          //   onChanged: (value) {},
          // ),
          Wrap(
            spacing: 4,
            runSpacing: -10,
            runAlignment: WrapAlignment.start,
            clipBehavior: Clip.none,
            children: [
              Chip(
                label: Text(
                  'Appliance repair',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              Chip(
                label: Text(
                  'Electrician',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s24),
          DefaultButton(onPressed: () {}, title: 'Save')
        ],
      ),
    );
  }
}
