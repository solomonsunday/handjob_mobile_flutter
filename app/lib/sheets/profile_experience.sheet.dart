import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class ProfileExperienceSheet extends StatelessWidget {
  const ProfileExperienceSheet({
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
              Text('Experience'),
            ],
          ),
          SizedBox(height: AppSize.s24),
          InputField(
            label: "Job title",
            hintText: 'Enter job title',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          InputField(
            label: 'Business name',
            hintText: 'Enter business name',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          Row(
            children: [
              Expanded(
                child: DatePicker(
                  onSelected: (p0) {},
                  label: 'Start date',
                  hintText: 'Select',
                ),
              ),
              SizedBox(width: AppSize.s12),
              Expanded(
                child: DatePicker(
                  onSelected: (p0) {},
                  label: 'End date',
                  hintText: 'Select',
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s12),
          InputField(
            label: 'Job category',
            hintText: 'Enter',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          InputField(
            label: 'Location',
            hintText: 'Enter',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          Textarea(
            label: 'Describe the nature of work',
            hintText: 'Enter',
            fillColor: ColorManager.kWhiteColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(height: AppSize.s12),
          DefaultCheckBox(
            value: false,
            onChanged: (value) {},
            richText: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Set as current',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.s24),
          DefaultButton(onPressed: () {}, title: 'Save changes')
        ],
      ),
    );
  }
}
