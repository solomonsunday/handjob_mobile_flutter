import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/user.model.dart';

class ProfileContact extends StatelessWidget {
  const ProfileContact({
    Key? key,
    required this.currentUser,
    required this.busy,
    this.showContactSheet,
    this.requestOTP,
    this.sendEmail,
  }) : super(key: key);
  final User? currentUser;
  final VoidCallback? showContactSheet;
  final Function()? requestOTP;
  final Function()? sendEmail;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    // print('user profile for ocntact: ${model.currentUser?.toJson()}');
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
            onTap: showContactSheet,
          ),
          const SizedBox(height: AppSize.s24),
          Text(
            'Email address',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          GestureDetector(
            onTap: sendEmail,
            child: Text(
              currentUser?.contactEmail ?? currentUser?.email ?? "",
              style: getRegularStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s12,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s12),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Phone number',
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              !busy && currentUser != null && currentUser?.phoneNumber != null
                  ? InkWell(
                      onTap: requestOTP,
                      child: Row(
                        children: [
                          currentUser!.phoneNumberVerified!
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8,
                                    vertical: AppSize.s4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorManager.kGreen,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s16),
                                  ),
                                  child: Text(
                                    'Verified',
                                    style: getRegularStyle(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Verify',
                                  style: getRegularStyle(
                                    color: const Color(0xffFFC107),
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                        ],
                      ),
                    )
                  : const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 1),
                    )
            ],
          ),
          Text(
            currentUser?.contactPhoneNumber ?? "",
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            'Location',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          Text(
            '${currentUser?.address}',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
        ],
      ),
    );
  }
}
