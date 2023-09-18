import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/ui/settings/change_password/change_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication.service.dart';

class ChangePasswordViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid ;

    bool _retypePasswordVisibility = true;
    bool get retypePasswordVisibility => _retypePasswordVisibility;

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
      await _authenticationService.logout();
      _navigationService.clearStackAndShow(Routes.authView);
      Fluttertoast.showToast(
        msg: 'Password was changed!',
        toastLength: Toast.LENGTH_LONG,
      );
    } on DioError catch(e){
      _dialogService.showDialog(title: "Error", description: e.response?.data['message']);
    } finally {
      setBusy(false);
    }
  }

  @override
  void setFormStatus() {
    if(oldPasswordValue == null ||  (oldPasswordValue ?? "").isEmpty ){
      _isFormValid = false;
      return;
    }

    if(newPasswordValue == null || (newPasswordValue ?? "").isEmpty){
      _isFormValid = false;
      return;
    }

    if(confirmPasswordValue == null || (confirmPasswordValue ?? "").isEmpty ){
      _isFormValid = false;
      return;
    }

    _isFormValid = true;
  }

    toggleRetypePasswordVisibility() {
    _retypePasswordVisibility = !_retypePasswordVisibility;
    notifyListeners();
  }

}
