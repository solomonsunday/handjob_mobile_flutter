import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/home/home_view.dart';
import 'package:handjob_mobile/ui/profile/profile_view.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'main_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => Scaffold(
        body: getView(model.currentIndex),
        drawer: MainDrawerWidget(),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 12,
          color: ColorManager.kNavDarkColor,
          elevation: 0,
          child: SizedBox(
            height: 60,
            child: BottomNavigationBar(
              unselectedLabelStyle: getRegularStyle(
                color: ColorManager.kWhiteColor,
              ),
              selectedLabelStyle: getMediumStyle(
                color: ColorManager.kWhiteColor,
              ),
              showSelectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.handyman_sharp,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Instant Hire',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.card_giftcard,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Jobs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Chats',
                ),
              ],
              currentIndex: model.currentIndex,
              onTap: (value) => model.setIndex(value),
              backgroundColor: ColorManager.kPrimaryColor,
              type: BottomNavigationBarType.fixed,
            ),
          ),
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
    switch (currentIndex) {
      case HOME_VIEW:
        return HomeView();
      case POST_VIEW:
      case INSTANT_HIRE_VIEW:
      case JOB_VIEW:
      case CHAT_VIEW:
        return Center(
          child: Text('chat View'),
        );
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
                    onTap: () {},
                    child: const Icon(
                      Icons.cancel,
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
                  const CircleAvatar(
                    backgroundColor: ColorManager.kDarkColor,
                    radius: AppSize.s40,
                  ),
                  const SizedBox(height: AppSize.s8),
                  Text(
                    'John Demola',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    'Electrician',
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
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.groups_sharp,
                  color: ColorManager.kDarkColor,
                ),
                title: Text(
                  AppString.connectionRequestTitleText,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                horizontalTitleGap: 1,
              ),
              ListTile(
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
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
