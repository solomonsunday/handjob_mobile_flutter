import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

class ProfileTab extends ViewModelWidget<ProfileViewModel> {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
      ),
      child: TabBarView(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return TabItem();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return TabItem();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ReviewItem();
              },
            ),
          ),
        ],
      ),
    );
    // return DefaultTabController(
    //   length: 2,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       TabBar(
    //         tabs: [
    //           Tab(
    //             child: Text(
    //               'Applied jobs',
    //               style: getRegularStyle(
    //                 color: ColorManager.kDarkColor,
    //               ),
    //             ),
    //           ),
    //           Tab(
    //             child: Text(
    //               'Instant hires',
    //               style: getRegularStyle(
    //                 color: ColorManager.kDarkColor,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Expanded(
    //         child: TabBarView(
    //           children: [
    //             Container(
    //               child: Text("Applied jobs container"),
    //             ),
    //             Container(
    //               child: Text("Instant hires container"),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundColor: ColorManager.kDarkColor,
                  radius: 16,
                ),
              ),
              SizedBox(width: AppSize.s8),
              Text(
                'Steven Okoro',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: ColorManager.kSecondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: AppSize.s4),
                  Text(
                    '5 mins ago',
                    style: getRegularStyle(
                      fontSize: FontSize.s10,
                      color: ColorManager.kPrimary400Color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSize.s12),
          Text(
            'Electrician needed at 113 Gowon estate, Iyana ipaja',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            'inveter servicing',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s20),
          Text(
            'MEET UP LOCATION: RainOil filing station, ipaja road',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s12),
          Row(
            children: [
              DefaultButton(
                onPressed: () {},
                title: 'Today',
                leadingIcon: Icons.calendar_month_rounded,
                leadingIconColor: ColorManager.kSecondaryColor,
                buttonType: ButtonType.outline,
                paddingHeight: 12,
                paddingWidth: 4,
                borderRadius: 4,
              ),
              SizedBox(width: AppSize.s4),
              DefaultButton(
                onPressed: () {},
                title: 'Alimosho',
                leadingIcon: Icons.pin_drop_outlined,
                leadingIconColor: ColorManager.kSecondaryColor,
                buttonType: ButtonType.outline,
                paddingHeight: 12,
                paddingWidth: 4,
                borderRadius: 4,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefaultButton(
                onPressed: () {},
                title: 'Applied',
                trailingIcon: Icons.check,
                trailingIconColor: ColorManager.kSecondaryColor,
                buttonType: ButtonType.outline,
                paddingHeight: 12,
                paddingWidth: 4,
                borderRadius: 4,
              ),
              const SizedBox(width: AppSize.s8),
              Text(
                'Awaiting response...',
                style: getRegularStyle(
                  color: ColorManager.kPrimary200Color,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Steven Okoro',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          const SizedBox(height: AppSize.s4),
          SvgPicture.asset(
            'assets/images/rating.svg',
          ),
          const SizedBox(height: AppPadding.p8),
          Text(
            'He did a good enough job. I had no complaints',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}
