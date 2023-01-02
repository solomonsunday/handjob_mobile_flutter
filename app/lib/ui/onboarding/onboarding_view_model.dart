import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/dialogs/account_type.dialog.dart';
import 'package:handjob_mobile/enums/dialog.enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../utils/pos_contants.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  navigateToAuth() async {
    _navigatorService.replaceWith(Routes.authView);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(IS_FIRST_TIME_USER, false);
  }

  showDialog() async {
    var response =
        await _dialogService.showCustomDialog(variant: DialogType.ACCOUNT_TYPE);
    if (response!.confirmed) {
      switch (response.data) {
        case CUSTOMER:
          // do a customer job
          _navigatorService.navigateTo(Routes.customerSignupView);
          break;
        case ARTISAN:
          // do an artisan job
          _navigatorService.navigateTo(Routes.artisanSignupView);
          break;
        default:
          {
            _navigatorService.navigateTo(Routes.customerSignupView);
          }

          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setBool(IS_FIRST_TIME_USER, false);
      }
    }
  }
}
