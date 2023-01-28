import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/components/profile_contact.dart';
import 'package:handjob_mobile/ui/profile/components/profile_education_apprenticeship.dart';
import 'package:handjob_mobile/ui/profile/components/profile_services.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'components/profile_action_buttons.dart';
import 'components/profile_bio.dart';
import 'components/profile_experience.dart';
import 'components/profile_header.dart';
import 'components/profile_portfolio.dart';
import 'components/profile_tab.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) async {
        await model.fetchAppliedJobs();
        await model.fetchInstantHires();
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
                  const SliverToBoxAdapter(child: ProfileHeader()),
                  const SliverToBoxAdapter(
                      child: SizedBox(height: AppSize.s12)),
                  const SliverToBoxAdapter(child: ProfileServices()),
                  const SliverToBoxAdapter(
                      child: SizedBox(height: AppSize.s12)),
                  const SliverToBoxAdapter(child: ProfileExperience()),
                  const SliverToBoxAdapter(
                      child: ProfileEducationApprenticeship()),
                  const SliverToBoxAdapter(child: ProfileContact()),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: ColorManager.kPrimary100Color,
                      thickness: 1,
                    ),
                  ),
                  const SliverToBoxAdapter(child: ProfilePortfolio()),
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
