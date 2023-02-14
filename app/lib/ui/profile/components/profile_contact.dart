import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ProfileContact extends ViewModelWidget<ProfileViewModel> {
  const ProfileContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
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
              onTap: () => model.showContactSheet({
                    "email": model.currentUser?.contactEmail ??
                        model.currentUser?.email ??
                        "",
                    "phone": model.currentUser?.phoneNumber ?? "",
                    "state": model.currentUser?.state ?? "",
                    "lga": model.currentUser?.lga ?? "",
                    "address": model.currentUser?.address ?? "",
                  })),
          const SizedBox(height: AppSize.s24),
          Text(
            'Email address',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          Text(
            model.currentUser?.contactEmail ?? model.currentUser?.email ?? "",
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
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
              !model.busy(REQUEST_OTP)
                  ? InkWell(
                      onTap: () async {
                        //request otp
                        await model.requestOTP();
                        model.showVerifyPhoneSheet();
                      },
                      child: Row(
                        children: [
                          model.currentUser!.phoneNumberVerified!
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
            model.currentUser?.contactPhoneNumber ?? "",
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
            '${model.currentUser?.address}',
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
