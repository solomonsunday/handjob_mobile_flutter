import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class ProfileEducationSheet extends StatelessWidget {
  const ProfileEducationSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      onClose: () => completer!(SheetResponse(confirmed: false)),
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
              Text('Education'),
            ],
          ),
          SizedBox(height: AppSize.s24),
          // DefaultDropDownField(
          //   label: "Job title",
          //   hint: 'Enter job title',
          //   dropdownItems: model.qualifications,
          //   onChanged: (value){},
          //   value: model.selectedQualification,
          // ),
          // SizedBox(height: AppSize.s12),
          InputField(
            label: 'Course',
            hintText: 'Enter course name',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          InputField(
            label: 'Year of graduation',
            hintText: 'Enter ',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          InputField(
            label: 'Institution name',
            hintText: 'Enter ',
            fillColor: ColorManager.kWhiteColor,
          ),
          SizedBox(height: AppSize.s12),
          Row(
            children: [
              Expanded(
                child: InputField(
                  label: 'City',
                  hintText: 'Enter',
                ),
              ),
              SizedBox(width: AppSize.s12),
              Expanded(
                child: DatePicker(
                  onSelected: (p0) {},
                  label: 'Country',
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
