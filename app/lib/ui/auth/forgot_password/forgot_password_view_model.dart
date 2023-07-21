import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/forgot_password/forgot_password_view.form.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

class ForgotPasswordViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  recoverPassword() async {
    runBusyFuture(reecoverPasswordRequest());
  }

  Future reecoverPasswordRequest() async {
    setBusy(true);
    try {
      var formData = {
        "email": emailValue?.toString(),
      };
      print('form data: $formData');
      await _authenticationService.requestForgotPassword(formData);
      Fluttertoast.showToast(
        msg: "A code has been sent to your mail to reset your password.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kDarkCharcoal,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _navigationService.navigateToResetPasswordView(email: emailValue!);
    } on DioError catch (error) {
      if(error.response!.statusCode! >= 500){
        setError("An unexpected error has occurred");
        return;
      }
      print("dio error: ${error.response?.statusCode}");
      throw HttpException(error.response!.data["message"]);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void navigateToLogin() => _navigationService.navigateTo(Routes.authView);

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
