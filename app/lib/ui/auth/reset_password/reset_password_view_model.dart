import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/ui/auth/reset_password/reset_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication.service.dart';
import '../../../utils/http_exception.dart';

class ResetPasswordViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  bool get passwordVisibility => _passwordVisibility;
  bool get confirmPasswordVisibility => _confirmPasswordVisibility;

  togglePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  toggleConfirmPasswordVisibility() {
    _confirmPasswordVisibility = !_confirmPasswordVisibility;
    notifyListeners();
  }

  String _email = "";
  String get email => _email;
  void setEmail(String value) {
    _email = value;
  }

  // resetPassword() async {
  //   runBusyFuture(resetPasswordRequest());
  // }

  Future resetPassword() async {
    setBusy(true);
    print('result  $email, $codeValue ?? "", ');
    try {
      var formData = {
        "password": passwordValue,
        "confirmPassword": confirmPasswordValue
      };
      await _authenticationService.requestResetPassword(
        email,
        codeValue ?? "",
        formData,
      );

      Fluttertoast.showToast(
        msg: "Password was successfully changed!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kDarkCharcoal,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _navigationService.navigateTo(Routes.authView);
    } on DioError catch (error) {
      print('error.response!.data ${error.response!.data}');
      throw HttpException(error.response!.data["message"]);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
