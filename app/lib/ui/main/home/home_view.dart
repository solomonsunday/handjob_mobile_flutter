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
      padding: const EdgeInsets.only(
        left: AppPadding.p8,
        right: AppPadding.p8,
        bottom: AppPadding.p8,
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ColorManager.kDarkCharcoal,
              ),
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
          ),
          SizedBox(width: AppSize.s8),
          Expanded(
            child: InputField(
              hintText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                size: AppSize.s20,
              ),
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
        return HomeCard();
      },
    );
  }
}
