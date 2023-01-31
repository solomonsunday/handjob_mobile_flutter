import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/chat/chat_view.dart';
import 'package:handjob_mobile/ui/main/home/home_view.dart';
import 'package:handjob_mobile/ui/main/instant_hire/instant_hire_view.dart';
import 'package:handjob_mobile/ui/main/jobs/jobs_view.dart';
import 'package:handjob_mobile/ui/main/post/post_view.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'main_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) async {
        await model.fetchStates();
        await model.fetchLGA();
        await model.fetchCountries();
        await model.fetchQualification();
        await model.fetchPost();
      },
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => Scaffold(
        body: getView(model.currentIndex),
        drawer: const MainDrawerWidget(),
        bottomNavigationBar: CustomBottomBar(
          containerHeight: 70,
          backgroundColor: Colors.black,
          selectedIndex: model.currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => model.setCurrentIndex(index),
          items: [
            BottomNavBarItem(
              icon: Icons.home,
              title: Text(
                'Home',
                style: getBoldStyle(
                  color: ColorManager.kWhiteColor,
                  fontSize: FontSize.s9,
                ),
              ),
              inactiveColor: ColorManager.kWhiteColor,
              activeColor: ColorManager.kSecondaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavBarItem(
              icon: Icons.add_box_outlined,
              title: Text(
                'Post',
                style: getBoldStyle(
                  color: ColorManager.kWhiteColor,
                  fontSize: FontSize.s9,
                ),
              ),
              inactiveColor: ColorManager.kWhiteColor,
              activeColor: ColorManager.kSecondaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavBarItem(
              icon: Icons.handyman_sharp,
              title: Text(
                'Instant Hire',
                style: getBoldStyle(
                  color: ColorManager.kWhiteColor,
                  fontSize: FontSize.s9,
                ),
              ),
              inactiveColor: ColorManager.kWhiteColor,
              activeColor: ColorManager.kSecondaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavBarItem(
              icon: Icons.card_giftcard,
              title: Text(
                'Jobs',
                style: getBoldStyle(
                  color: ColorManager.kWhiteColor,
                  fontSize: FontSize.s9,
                ),
              ),
              inactiveColor: ColorManager.kWhiteColor,
              activeColor: ColorManager.kSecondaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavBarItem(
              icon: Icons.chat_bubble,
              title: Text(
                'Chats',
                style: getBoldStyle(
                  color: ColorManager.kWhiteColor,
                  fontSize: FontSize.s9,
                ),
              ),
              inactiveColor: ColorManager.kWhiteColor,
              activeColor: ColorManager.kSecondaryColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static const int HOME_VIEW = 0;
  static const int POST_VIEW = 1;
  static const int INSTANT_HIRE_VIEW = 2;
  static const int JOB_VIEW = 3;
  static const int CHAT_VIEW = 4;

  getView(int currentIndex) {
    print('reacted to chanages: $currentIndex');
    switch (currentIndex) {
      case HOME_VIEW:
        return HomeView();
      case POST_VIEW:
        return PostView();
      case INSTANT_HIRE_VIEW:
        return InstantHireView();
      case JOB_VIEW:
        return JobsView();
      case CHAT_VIEW:
        return ChatView();
      default:
        return Container();
    }
  }
}

class MainDrawerWidget extends ViewModelWidget<MainViewModel> {
  const MainDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel model) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: ColorManager.kWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSize.s40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HandJobs',
                    style: getSemiBoldStyle(
                      color: ColorManager.kPrimaryColor,
                      fontSize: FontSize.s24,
                    ),
                  ),
                  GestureDetector(
                    onTap: model.navigateBack,
                    child: const Icon(
                      Icons.close,
                      color: ColorManager.kPrimaryColor,
                      size: AppSize.s24,
                    ),
                  )
                ],
              ),
              const SizedBox(height: AppSize.s24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSize.s12),
                  // model.currentUser?.imageUrl == null
                  //     ? const CircleAvatar(
                  //         backgroundColor: ColorManager.kDarkColor,
                  //         radius: AppSize.s40,
                  //         backgroundImage:
                  //             AssetImage('assets/images/logo.jpeg'),
                  //       )
                  //     : const CircleAvatar(
                  //         backgroundColor: ColorManager.kDarkColor,
                  //         radius: AppSize.s40,
                  //         backgroundImage: CachedNetworkImage(
                  //           imageUrl: portfolio,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  model.currentUser?.imageUrl == null
                      ? Image.asset(
                          'assets/images/logo.jpeg',
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: model.currentUser!.imageUrl!,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                  Colors.red,
                                  BlendMode.colorBurn,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                  backgroundColor: ColorManager.kDarkCharcoal,
                                  valueColor: AlwaysStoppedAnimation(
                                    ColorManager.kPrimaryColor,
                                  )),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: ColorManager.kRed,
                          ),
                        ),

                  const SizedBox(height: AppSize.s8),
                  Text(
                    '${model.currentUser?.firstName} ${model.currentUser?.lastName}',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    '${model.currentUser?.profession ?? model.currentUser?.accountType}',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s12,
                    ),
                  ),
                  const SizedBox(height: AppSize.s8),
                  DefaultButton(
                    onPressed: model.navigateToProfile,
                    title: 'View profile',
                    buttonType: ButtonType.text,
                    buttonTextColor: ColorManager.kDarkColor,
                    fontSize: FontSize.s11,
                  ),
                ],
              ),
              const Divider(
                color: ColorManager.kPrimary100Color,
                thickness: 1,
              ),
              // ListTile(
              //   onTap: model.navigateToConnectionRequests,
              //   leading: const Icon(
              //     Icons.groups_sharp,
              //     color: ColorManager.kDarkColor,
              //   ),
              //   title: Text(
              //     AppString.connectionRequestTitleText,
              //     style: getRegularStyle(
              //       color: ColorManager.kDarkColor,
              //       fontSize: FontSize.s14,
              //     ),
              //   ),
              //   horizontalTitleGap: 1,
              // ),
              ListTile(
                onTap: model.navigateToContacts,
                leading: const Icon(
                  Icons.perm_contact_cal,
                  color: ColorManager.kDarkColor,
                ),
                title: Text(
                  AppString.contactsTitleText,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                horizontalTitleGap: 1,
              ),
              ListTile(
                onTap: model.navigateToSettings,
                leading: const Icon(
                  Icons.settings,
                  color: ColorManager.kDarkColor,
                ),
                title: Text(
                  AppString.settingsTitleText,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                horizontalTitleGap: 1,
              ),
              ListTile(
                onTap: model.navigateToFAQs,
                leading: const Icon(
                  Icons.help,
                  color: ColorManager.kDarkColor,
                ),
                title: Text(
                  AppString.faqs,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                horizontalTitleGap: 1,
              ),
              ListTile(
                onTap: model.navigateToHelpAndSupport,
                leading: const Icon(
                  Icons.help_outline,
                  color: ColorManager.kDarkColor,
                ),
                title: Text(
                  AppString.helpAndSupportTitleText,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                horizontalTitleGap: 1,
              ),
              ListTile(
                onTap: model.logout,
                leading: const Icon(
                  Icons.logout,
                  color: ColorManager.kDarkColor,
                ),
                title: Text(
                  AppString.signOutTitleText,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                horizontalTitleGap: 1,
              ),
            ],
          ),
        ),
      ),
      elevation: AppSize.s4,
    );
  }
}
