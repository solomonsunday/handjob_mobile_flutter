import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../dialogs/account_type.dialog.dart';
import '../../enums/dialog.enum.dart';

class AuthViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  navigateToForgotPassword() =>
      _navigationService.navigateTo(Routes.forgotPasswordView);

  // String? _email;
  // String? _password;
  bool _visibility = true;

  String? get email => emailController.text;
  String? get password => passwordController.text;
  bool get visibility => _visibility;

  toggleVisibility() {
    _visibility = !_visibility;
    notifyListeners();
  }

  // handleEmail(String? value) {
  //   _email = value;
  //   notifyListeners();
  // }

  // handlePassword(String? value) {
  //   _password = value;
  //   notifyListeners();
  // }

  login() {
    runBusyFuture(loginTask());
    // _navigationService.replaceWith(Routes.mainView);
  }

  Future<Auth> loginTask() async {
    var formData = {
      "email": email,
      "password": password,
      "app": "Artisan",
    };
    setBusy(true);
    notifyListeners();

    try {
      Auth response = await _authenticationService.login(formData);
      await _authenticationService.getCurrentBaseUser();
      _navigationService.replaceWith(Routes.mainView);
      return response;
    } on DioError catch (err) {
      throw HttpException("An error occured: please enter a valid credential");
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
          _navigationService.navigateTo(Routes.customerSignupView);
          break;
        case ARTISAN:
          // do an artisan job
          _navigationService.navigateTo(Routes.artisanSignupView);
          break;
        default:
          _navigationService.navigateTo(Routes.customerSignupView);
      }
    }
  }
}
