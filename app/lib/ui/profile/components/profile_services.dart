import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ProfileServices extends ViewModelWidget<ProfileViewModel> {
  const ProfileServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileActionHeader(
            icon: Icons.tag,
            title: 'Services',
            onTap: model.showServiceSheet,
          ),
          const SizedBox(height: AppSize.s8),
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
              Chip(
                label: Text(
                  'Plumbing',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              Chip(
                label: Text(
                  'Baker',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              Chip(
                label: Text(
                  'repair',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
