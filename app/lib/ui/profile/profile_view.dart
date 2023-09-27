import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../shared/components/profile/profile_contact.dart';
import '../shared/components/profile/profile_education_apprenticeship.dart';
import '../shared/components/profile/profile_experience.dart';
import '../shared/components/profile/profile_header.dart';
import '../shared/components/profile/profile_portfolio.dart';
import '../shared/components/profile/profile_services.dart';
import '../shared/components/profile/profile_tab.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) async {
        await model.fetchAppliedJobs();
        await model.fetchInstantHires();
        await model.fetchContactsCount();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.kWhiteColor,
            leading: GestureDetector(
              onTap: () {
                model.goBack();
              },
              child: const Icon(
                Icons.arrow_back,
                size: 24,
                color: ColorManager.kDarkColor,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              'Profile',
              style: getBoldStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s16,
              ),
            ),
          ),
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              scrollBehavior: const ScrollBehavior(),
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: ProfileHeader(
                      currentUser: model.currentUser,
                      uploadProfileAvatar: () async =>
                          await model.uploadProfileAvatar(),
                      uploadProfileCover: () async =>
                          await model.uploadProfileCover(),
                      isUploadingAvatar: model.busy(PROFILE_AVATAR_UPLOAD),
                      isUploadingCover: model.busy(PROFILE_COVER_UPLOAD),
                      connectionCount: model.contactListCount ?? 0,
                      rating: 3,
                    ),
                  ),
                  const SliverToBoxAdapter(
                      child: SizedBox(height: AppSize.s12)),
                  SliverToBoxAdapter(
                      child: ProfileServices(
                    currentUser: model.currentUser,
                    showServiceSheet: model.showServiceSheet,
                  )),
                  SliverToBoxAdapter(
                      child: ProfileContact(
                    currentUser: model.currentUser,
                    busy: model.busy(REQUEST_OTP),
                    requestOTP: () async {
                      await model.requestOTP();
                      model.showVerifyPhoneSheet(model.currentUser);
                    },
                    showContactSheet: () =>
                        model.showContactSheet(model.currentUser),
                    sendEmail: null,
                    makePhoneCall: null,
                  )),
                  const SliverToBoxAdapter(
                      child: SizedBox(height: AppSize.s12)),
                  SliverToBoxAdapter(
                    child: ProfileExperience(
                      currentUser: model.currentUser,
                      showExperienceSheet: () =>
                          model.showExperienceSheet(null),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProfileEducationApprenticeship(
                      currentUser: model.currentUser,
                      showEducationApprenticeSheet: () =>
                          model.showEducationApprenticeSheet(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: ColorManager.kPrimary100Color,
                      thickness: 1,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProfilePortfolio(
                      currentUser: model.currentUser,
                      showPortfolioSheet: () => model.showPortfolioSheet(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: ColorManager.kPrimary100Color,
                      thickness: 1,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p24,
                      ),
                      child: TabBar(
                          indicatorColor: ColorManager.kSecondaryColor,
                          tabs: [
                            Tab(
                              child: Text(
                                'Applied jobs',
                                style: getRegularStyle(
                                  color: ColorManager.kDarkColor,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Instant hires',
                                style: getRegularStyle(
                                  color: ColorManager.kDarkColor,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Reviews (${model.currentUser?.reviews?.length})',
                                style: getRegularStyle(
                                  color: ColorManager.kDarkColor,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  )
                ];
              },
              body: const Padding(
                padding: EdgeInsets.only(top: AppPadding.p16),
                child: ProfileTab(),
              ),
            ),
          ),
        );
      },
    );
  }
}
