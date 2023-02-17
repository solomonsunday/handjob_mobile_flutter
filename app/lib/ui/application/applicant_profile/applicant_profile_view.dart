import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/applicant.model.dart';
import 'package:handjob_mobile/ui/application/applicant_profile/applicant_profile_view_model.dart';
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
    required this.applicant,
  });

  final Applicant applicant;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicantProfileViewModel>.reactive(
        viewModelBuilder: () => ApplicantProfileViewModel(),
        onModelReady: (model) {
          model.getAccount(applicant.applicantId!);
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
                          isView: true),
                      const SizedBox(height: AppSize.s12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: DefaultButton(
                          onPressed: () {},
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
                        busy: false,
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
