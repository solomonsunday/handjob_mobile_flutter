import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/enums/dialog.enum.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication.service.dart';

class VerifyEmailViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  showSuccessDialog() async {
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.ACCOUNT_CREATED);
    if (response!.confirmed) {
      _navigationService.navigateTo(Routes.mainView);
    }
  }
}
