import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class Setting {
  IconData? icon;
  String? text;

  Setting(this.icon, this.text);
}

class SettingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<Setting> get settingMenu => [
        Setting(Icons.hardware, "Subscriptions"),
        Setting(Icons.notifications_none, "Notifications"),
        Setting(Icons.login, "Sign in and security"),
      ];

  goBack() => _navigationService.back();

  void navigateToChangePassword() =>
      _navigationService.navigateTo(Routes.changePasswordView);
}
