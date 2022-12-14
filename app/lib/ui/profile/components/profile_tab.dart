import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/text_styles.dart';

class ProfileTab extends ViewModelWidget<ProfileViewModel> {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
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
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  child: Text("Applied jobs container"),
                ),
                Container(
                  child: Text("Instant hires container"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
