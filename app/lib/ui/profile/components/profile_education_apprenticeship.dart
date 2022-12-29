import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ProfileEducationApprenticeship extends ViewModelWidget<ProfileViewModel> {
  const ProfileEducationApprenticeship({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ProfileActionHeader(
            icon: Icons.menu_book_rounded,
            title: 'Education/ Apprenticeship',
            onTap: model.showEducationApprenticeSheet,
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            'No education added',
            style: getRegularStyle(
              color: ColorManager.kGrey,
              fontSize: FontSize.s12,
            ),
          ),
        ],
      ),
    );
  }
}
