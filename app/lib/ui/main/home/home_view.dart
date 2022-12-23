import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/components/home_card.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/text_styles.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.kDarkColor,
          leading: Icon(
            Icons.menu,
            size: AppSize.s24,
            color: ColorManager.kWhiteColor,
          ),
          title: Text(
            'HandJob',
            style: getBoldStyle(color: ColorManager.kWhiteColor),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.notifications),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.kSecondaryColor,
                        borderRadius: BorderRadius.circular(AppSize.s32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          '2',
                          style: getBoldStyle(
                            color: ColorManager.kWhiteColor,
                            fontSize: FontSize.s10,
                          ),
                        ),
                      ),
                    ),
                    top: 10,
                    right: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            HomeSearchWidget(),
            Expanded(child: HomePostWidget()),
          ],
        ),
      ),
    );
  }
}

class HomeSearchWidget extends ViewModelWidget<HomeViewModel> {
  const HomeSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p12,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorManager.kGrey,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xffd9d9d9),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://xsgames.co/randomusers/avatar.php?g=male'),
              ),
            ),
          ),
          SizedBox(width: AppSize.s8),
          Expanded(
            child: InputField(
              hintText: 'Search',
              paddingBottom: 0,
              paddingTop: 0,
              prefixIcon: Icon(
                Icons.search,
                color: ColorManager.kGrey3,
              ),
              // onChanged: model.handleSearch,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePostWidget extends ViewModelWidget<HomeViewModel> {
  const HomePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return HomeCard(
          onImageClick: () {
            model.onPostImageClick();
          },
        );
      },
    );
  }
}
