import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ProfileContact extends ViewModelWidget<ProfileViewModel> {
  const ProfileContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileActionHeader(
            icon: Icons.phone,
            title: 'Contact Us',
            onTap: model.showContactSheet,
          ),
          const SizedBox(height: AppSize.s24),
          Text(
            'Email address',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          Text(
            'johndemola@gmail.com',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          const SizedBox(height: AppSize.s12),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.red,
                size: 8,
              ),
              const SizedBox(width: AppSize.s8),
              Expanded(
                child: Text(
                  'Phone number',
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              InkWell(
                onTap: model.showVerifyPhoneSheet,
                child: Text(
                  'Verify',
                  style: getRegularStyle(
                    color: Color(0xffFFC107),
                    fontSize: FontSize.s12,
                  ),
                ),
              )
            ],
          ),
          Text(
            'add phone number',
            style: getRegularStyle(
              color: ColorManager.kGrey,
              fontSize: FontSize.s12,
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.red,
                size: 8,
              ),
              const SizedBox(width: AppSize.s8),
              Expanded(
                child: Text(
                  'Location',
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'add location',
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
