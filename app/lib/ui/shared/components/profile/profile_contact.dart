import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/user.model.dart';

class ProfileContact extends StatelessWidget {
  const ProfileContact({
    Key? key,
    required this.currentUser,
    required this.busy,
    this.isLoggedInUser = true,
    this.revealContactDetail = true,
    this.showContactSheet,
    this.requestOTP,
    this.sendEmail,
    this.makePhoneCall,
  }) : super(key: key);
  final User? currentUser;
  final VoidCallback? showContactSheet;
  final Function()? requestOTP;
  final Function()? sendEmail;
  final Function()? makePhoneCall;
  final bool busy;
  final bool isLoggedInUser;
  final bool revealContactDetail;

  @override
  Widget build(BuildContext context) {
    print('isLoggedInUser: $isLoggedInUser');
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
            title: 'Contact Info',
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
          !revealContactDetail
              ? Container(
                  width: 80,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: ColorManager.kDarkColor,
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        currentUser?.contactEmail ?? currentUser?.email ?? "",
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorManager.kSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            enableFeedback: true,
                            color: ColorManager.kWhiteColor,
                            onPressed: sendEmail,
                            icon: const Icon(
                              Icons.email,
                              size: 20,
                              color: ColorManager.kWhiteColor,
                            )),
                      ),
                    ),
                  ],
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
              isLoggedInUser
                  ? Container(
                      child: !busy &&
                              currentUser != null 
                          ? InkWell(
                              onTap: currentUser?.contactPhoneNumber != null ? requestOTP : () {},
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
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s16),
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
                                            color: ColorManager.kDarkCharcoal,
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
                            ),
                    )
                  : Container(),
            ],
          ),
          !revealContactDetail
              ? Container(
                  width: 80,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: ColorManager.kDarkColor,
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            currentUser?.contactPhoneNumber ?? "",
                            style: getRegularStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s12,
                            ),
                          ),
                          !isLoggedInUser && currentUser!.phoneNumberVerified!
                              ? const Icon(
                                  Icons.verified,
                                  color: ColorManager.kSecondaryColor,
                                  size: 20,
                                )
                              : Container()
                        ],
                      ),
                    ),
                    if (currentUser?.contactPhoneNumber?.isNotEmpty ?? false)
                      SizedBox(
                        height: 38,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorManager.kSecondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              enableFeedback: true,
                              color: ColorManager.kWhiteColor,
                              onPressed: makePhoneCall,
                              icon: const Icon(
                                Icons.phone,
                                size: 20,
                                color: ColorManager.kWhiteColor,
                              )),
                        ),
                      ),
                  ],
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
            currentUser?.address ?? "",
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
