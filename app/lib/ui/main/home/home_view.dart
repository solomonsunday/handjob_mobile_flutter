import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/text_styles.dart';

import '../home_card.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.kDarkColor,
          leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: AppSize.s24,
              color: ColorManager.kWhiteColor,
            ),
          ),
          // title: Text(
          //   'HandJob',
          //   style: getBoldStyle(color: ColorManager.kWhiteColor),
          // ),
          title: Image.asset(
            'assets/images/HandJobs.png',
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: model.navigateToNotification,
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
          GestureDetector(
            onTap: () {
              model.navigateToProfile();
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Color(0xffd9d9d9),
              ),
              child: model.currentUser?.imageUrl == null
                  ? Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.jpeg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      imageUrl: model.currentUser?.imageUrl ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppSize.s8),
          const Expanded(
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
    // print('post widget: ${model.posts}');
    return ListView.builder(
      itemCount: model.posts.length,
      itemBuilder: (BuildContext context, int index) {
        return HomeCard(
          post: model.posts[index],
          onImageClick: () {
            model.onPostImageClick(model.posts[index]);
          },
        );
      },
    );
  }
}
