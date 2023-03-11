import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/main.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/forgot_password/forgot_password_view.form.dart';
import 'package:handjob_mobile/ui/auth/reset_password/reset_password_view.form.dart';
import 'package:handjob_mobile/utils/contants.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../dialogs/account_type.dialog.dart';
import '../../enums/dialog.enum.dart';
import '../../models/user.model.dart';

class AuthViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  navigateToForgotPassword() =>
      _navigationService.navigateTo(Routes.forgotPasswordView);

  // String? _email;
  // String? _password;
  bool _visibility = true;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool get visibility => _visibility;

  toggleVisibility() {
    _visibility = !_visibility;
    notifyListeners();
  }

  login() async {
    runBusyFuture(loginTask());
    // _navigationService.replaceWith(Routes.mainView);
  }

  Future<void> loginTask() async {
    var formData = {
      "email": emailValue,
      "password": passwordValue,
      "app": "Artisan",
    };
    setBusy(true);
    notifyListeners();

    try {
      Auth response = await _authenticationService.login(formData);
      await _authenticationService.getCurrentBaseUser();
      //subscribe to topics

      _navigationService.replaceWith(Routes.mainView);
      Fluttertoast.showToast(
        msg: 'login successfully!',
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    } on DioError catch (err) {
      _errorMessage = "An error occured: please enter a valid credential";
      _dialogService.showDialog(
        title: "An error occured",
        description: _errorMessage,
      );
      // throw HttpException("An error occured: please enter a valid credential");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  //show dialog
  showDialog() async {
    var response =
        await _dialogService.showCustomDialog(variant: DialogType.ACCOUNT_TYPE);
    if (response!.confirmed) {
      switch (response.data) {
        case CUSTOMER:
          // do a customer job
          _navigationService.navigateToCustomerSignupView();
          break;
        case ARTISAN:
          // do an artisan job
          _navigationService.navigateToArtisanSignupView();
          break;
        default:
        //
      }
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
