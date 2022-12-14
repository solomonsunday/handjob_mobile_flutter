import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'components/profile_action_buttons.dart';
import 'components/profile_bio.dart';
import 'components/profile_header.dart';
import 'components/profile_portfolio.dart';
import 'components/profile_tab.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: NestedScrollView(
            scrollBehavior: ScrollBehavior(),
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(child: ProfileHeader()),
                SliverToBoxAdapter(child: SizedBox(height: AppSize.s12)),
                SliverToBoxAdapter(child: ProfileActionButtons()),
                SliverToBoxAdapter(child: SizedBox(height: AppSize.s32)),
                SliverToBoxAdapter(child: ProfileBio()),
                SliverToBoxAdapter(
                  child: Divider(
                    color: ColorManager.kPrimary100Color,
                    thickness: 1,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: AppSize.s12)),
                SliverToBoxAdapter(child: ProfilePortfolio()),
                SliverToBoxAdapter(
                  child: Divider(
                    color: ColorManager.kPrimary100Color,
                    thickness: 1,
                  ),
                )
                // ProfileTab(),
              ];
            },
            body: ProfileTab(),
          ),
        );

        // return Scaffold(
        //   appBar: Navbar(
        //     leadingIcon: GestureDetector(
        //       onTap: model.goBack,
        //       child: const Icon(
        //         Icons.arrow_back,
        //         color: ColorManager.kPrimaryColor,
        //       ),
        //     ),
        //     title: "Profile",
        //     titleStyle: getBoldStyle(
        //       color: ColorManager.kDarkColor,
        //       fontSize: FontSize.s16,
        //     ),
        //   ),
        //   body: SingleChildScrollView(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisSize: MainAxisSize.min,
        //       children: const [
        //         ProfileHeader(),
        //         SizedBox(height: AppSize.s12),
        //         ProfileActionButtons(),
        //         SizedBox(height: AppSize.s32),
        //         ProfileBio(),
        //         Divider(
        //           color: ColorManager.kPrimary100Color,
        //           thickness: 1,
        //         ),
        //         SizedBox(height: AppSize.s12),
        //         ProfilePortfolio(),
        //         Divider(
        //           color: ColorManager.kPrimary100Color,
        //           thickness: 1,
        //         ),
        //         // ProfileTab(),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
