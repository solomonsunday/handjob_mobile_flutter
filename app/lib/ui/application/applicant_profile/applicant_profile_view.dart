import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/applicant.model.dart';
import 'package:handjob_mobile/ui/application/applicant_profile/applicant_profile_view_model.dart';
import 'package:handjob_mobile/utils/contants.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../shared/components/profile/profile_contact.dart';
import '../../shared/components/profile/profile_education_apprenticeship.dart';
import '../../shared/components/profile/profile_experience.dart';
import '../../shared/components/profile/profile_header.dart';
import '../../shared/components/profile/profile_portfolio.dart';
import '../../shared/components/profile/profile_services.dart';

class ApplicantProfileView extends StatelessWidget {
  const ApplicantProfileView({
    super.key,
    required this.applicantId,
    this.isAcceptedApplicant = false,
  });

  final String applicantId;
  final bool isAcceptedApplicant;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicantProfileViewModel>.reactive(
        viewModelBuilder: () => ApplicantProfileViewModel(),
        onViewModelReady: (model) {
          model.fetchConnectionRequests();
          model.getAccount(applicantId);
          model.fetchContactsCount();
        },
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: model.goBack,
                child: const Icon(
                  Icons.arrow_back,
                  color: ColorManager.kDarkColor,
                ),
              ),
              title: Text(
                'Profile',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              backgroundColor: ColorManager.kWhiteColor,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: model.user == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.kGrey1,
                      valueColor:
                          AlwaysStoppedAnimation(ColorManager.kSecondaryColor),
                    ),
                  )
                : ListView(
                    children: [
                      ProfileHeader(
                        currentUser: model.user,
                        uploadProfileAvatar: () {},
                        busy: false,
                        connectionCount: model.contactListCount ?? 0,
                        rating: 3,
                        isView: true,
                      ),
                      const SizedBox(height: AppSize.s12),
                      if (model.isContactExists(model.user?.email ?? "")?.id !=
                              null ||
                          model.accepted)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20),
                          child: DefaultButton(
                            onPressed: () => model.navigateToChat(model
                                .isContactExists(model.user?.email ?? "")!),
                            title: 'Message',
                            leadingIcon: const Icon(
                              Icons.message,
                              size: 24,
                            ),
                            leadingIconColor: ColorManager.kWhiteColor,
                            leadingIconSpace: 10,
                            buttonBgColor: ColorManager.kDarkColor,
                            buttonTextColor: ColorManager.kWhiteColor,
                            paddingHeight: 8,
                            paddingWidth: 8,
                          ),
                        ),
                      if (model.isContactExists(model.user?.email ?? "")?.id ==
                              null &&
                          model
                                  .isPendingAcceptConnection(
                                      model.user?.email ?? "")
                                  ?.id ==
                              null &&
                          !model.accepted)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20),
                          child: DefaultButton(
                            onPressed: () => model.handleSendConnectionRequest(
                                model.user?.id ?? ""),
                            title: model.isRequestSent ||
                                    model.pendingApprovalList
                                        .where((element) =>
                                            element == model.user?.id)
                                        .isNotEmpty
                                ? 'Pending Approval'
                                : 'Send Connection Request',
                            leadingIcon: const Icon(
                              Icons.message,
                              size: 24,
                            ),
                            leadingIconColor: ColorManager.kWhiteColor,
                            leadingIconSpace: 10,
                            buttonBgColor: ColorManager.kDarkColor,
                            buttonTextColor: ColorManager.kWhiteColor,
                            paddingHeight: 8,
                            paddingWidth: 8,
                            disabled: model.isRequestSent ||
                                model.busy(SEND_PROFILE_CONNECTION_REQUEST) ||
                                model.pendingApprovalList
                                    .where(
                                        (element) => element == model.user?.id)
                                    .isNotEmpty,
                            busy: model.busy(SEND_PROFILE_CONNECTION_REQUEST),
                          ),
                        ),
                      if (model.isContactExists(model.user?.email ?? "")?.id ==
                              null &&
                          model
                                  .isPendingAcceptConnection(
                                      model.user?.email ?? "")
                                  ?.id !=
                              null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20),
                          child: DefaultButton(
                            onPressed: () =>
                                model.acceptContact(model.user?.id ?? ""),
                            title: 'Accept Connection Request',
                            leadingIcon: const Icon(
                              Icons.message,
                              size: 24,
                            ),
                            leadingIconColor: ColorManager.kWhiteColor,
                            leadingIconSpace: 10,
                            buttonBgColor: ColorManager.kDarkColor,
                            buttonTextColor: ColorManager.kWhiteColor,
                            paddingHeight: 8,
                            paddingWidth: 8,
                            disabled: model.busy(ACCEPT_PROFILE_CONNECTION),
                            busy: model.busy(ACCEPT_PROFILE_CONNECTION),
                          ),
                        ),
                      const SizedBox(height: AppSize.s12),
                      ProfileServices(
                        currentUser: model.user,
                      ),
                      const SizedBox(height: AppSize.s12),
                      ProfileExperience(
                        currentUser: model.user,
                        isView: true,
                      ),
                      ProfileEducationApprenticeship(
                        currentUser: model.user,
                        isView: true,
                      ),
                      ProfileContact(
                        currentUser: model.user,
                        isLoggedInUser: model.user?.id == model.currentUser?.id,
                        revealContactDetail: model
                                    .isContactExists(model.user?.email ?? "")
                                    ?.id !=
                                null ||
                            isAcceptedApplicant ||
                            model.user?.accountType == ACCOUNT_ARTISAN,
                        busy: false,
                        sendEmail: () => model.sendEmail(model.user?.email),
                        makePhoneCall: () =>
                            model.makePhoneCall(model.user?.phoneNumber),
                      ),
                      const Divider(
                        color: ColorManager.kPrimary100Color,
                        thickness: 1,
                      ),
                      ProfilePortfolio(
                        currentUser: model.user,
                      ),
                      // Divider(
                      //   color: ColorManager.kPrimary100Color,
                      //   thickness: 1,
                      // ),
                    ],
                  ),
          );
        });
  }
}
