import 'package:dio/dio.dart';
import 'package:handjob_mobile/ui/settings/change_password/change_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication.service.dart';

class ChangePasswordViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  goBack() => _navigationService.back();

  changePassword() {
    runBusyFuture(changePasswordRequest());
  }

  changePasswordRequest() async {
    var formData = {
      "oldPassword": oldPasswordValue,
      "newPassword": newPasswordValue,
      "confirmPassword": confirmPasswordValue,
    };
    setBusy(true);
    try {
      await _authenticationService.changePassword(formData);
    } on DioError catch (err) {
    } finally {
      setBusy(false);
    }
  }

  @override
  void setFormStatus() {}
}
