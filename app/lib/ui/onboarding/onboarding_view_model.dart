import 'package:handjob_mobile/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../utils/pos_contants.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigator = locator<NavigationService>();

  navigateToAuth() async {
    _navigator.replaceWith(Routes.loginView);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(IS_FIRST_TIME_USER, false);
  }
}
