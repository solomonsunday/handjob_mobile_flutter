import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/settings/setting_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.nonReactive(
      viewModelBuilder: () => SettingViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: model.goBack,
              child: const Icon(
                Icons.arrow_back,
                color: ColorManager.kDarkColor,
              ),
            ),
            title: Text(
              'Settings',
              style: getBoldStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s16,
              ),
            ),
            backgroundColor: ColorManager.kWhiteColor,
            centerTitle: false,
            titleSpacing: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p24,
              vertical: AppPadding.p40,
            ),
            child: ListView.builder(
              itemCount: model.settingMenu.length,
              itemBuilder: (BuildContext context, int index) {
                Setting setting = model.settingMenu[index];
                return ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.all(AppPadding.p12),
                  tilePadding: EdgeInsets.zero,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  leading: Icon(
                    setting.icon,
                    size: AppSize.s24,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${setting.text}',
                        style: getBoldStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    if (index == 0) const VideoCallPreferenceWidget(),
                    if (index == 1) const NotificationPreferenceWidget(),
                    if (index == 2) const SigninSecurityPreferenceWidget(),
                    if (index == 3) const PolicyPreferenceWidget(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class VideoCallPreferenceWidget extends ViewModelWidget<SettingViewModel> {
  const VideoCallPreferenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return ListTile(
      onTap: () {},
      title: Text(
        "Video call",
        style: getBoldStyle(
          color: ColorManager.kDarkColor,
          fontSize: FontSize.s12,
        ),
      ),
      subtitle: Text(
        "Upgrade account to make video calls",
        style: getRegularStyle(
          color: ColorManager.kDarkColor,
          fontSize: FontSize.s12,
        ),
      ),
    );
  }
}

class NotificationPreferenceWidget extends ViewModelWidget<SettingViewModel> {
  const NotificationPreferenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Preferred notification method",
              style: getBoldStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s12,
              ),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: Text(
                'Receive SMS',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            SwitchListTile.adaptive(
              value: true,
              onChanged: (value) {},
              title: Text(
                'Receive Email',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            SwitchListTile.adaptive(
              value: true,
              onChanged: (value) {},
              title: Text(
                'Get hot deals',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            Text(
              "Calls",
              style: getBoldStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s12,
              ),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: Text(
                'Ringtone (Default)',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            SwitchListTile.adaptive(
              value: true,
              onChanged: (value) {},
              title: Text(
                'Vibrate',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          ]),
    );
  }
}

class SigninSecurityPreferenceWidget extends ViewModelWidget<SettingViewModel> {
  const SigninSecurityPreferenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return ListTile(
      onTap: model.navigateToChangePassword,
      title: Text(
        'Change password',
        style: getBoldStyle(
          color: ColorManager.kDarkColor,
          fontSize: FontSize.s12,
        ),
      ),
      subtitle: Text(
        '******',
        style: getBoldStyle(
          color: ColorManager.kDarkColor,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.arrow_forward,
          size: AppSize.s24,
        ),
      ),
    );
  }
}

class PolicyPreferenceWidget extends ViewModelWidget<SettingViewModel> {
  const PolicyPreferenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return ListTile(
      onTap: model.navigateToTermOfService,
      title: Text(
        'Show Terms & Conditions',
        style: getBoldStyle(
          color: ColorManager.kDarkColor,
          fontSize: FontSize.s12,
        ),
      ),
      trailing: GestureDetector(
        onTap: model.navigateToTermOfService,
        child: const Icon(
          Icons.arrow_forward,
          size: AppSize.s24,
        ),
      ),
    );
  }
}
