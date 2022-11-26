import 'package:flutter/material.dart';
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
                    Icons.chat_bubble,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Chats',
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
                    Icons.settings_applications,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Instant Hire',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                    color: ColorManager.kWhiteColor,
                  ),
                  label: 'Contacts',
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
  static const int CHAT_VIEW = 1;
  static const int JOB_VIEW = 2;
  static const int INSTANT_HIRE_VIEW = 3;
  static const int CONTACT_VIEW = 4;

  getView(int currentIndex) {
    switch (currentIndex) {
      case HOME_VIEW:
      case CHAT_VIEW:
      case JOB_VIEW:
      case INSTANT_HIRE_VIEW:
      case CONTACT_VIEW:
        return Center(
          child: Text('chat View'),
        );
      default:
        return Container();
    }
  }
}
