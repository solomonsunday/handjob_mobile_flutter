import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';

class CustomerSignupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool? _tos;
  bool? get tos => _tos;
  String? _username;
  String? _accountType;
  String? _email;
  String? _phone;
  String? _password;
  String? _confirmPassword;
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  String? get username => _username;
  String? get accountType => _accountType;
  String? get email => _email;
  String? get phone => _phone;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
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

  setTos(bool? value) {
    _tos = value;
    notifyListeners();
  }

  handleAccountType(String? value) {
    _accountType = value;
    notifyListeners();
  }

  handleUsername(String? value) {
    _username = value;
    notifyListeners();
  }

  handleEmail(String? value) {
    _email = value;
    notifyListeners();
  }

  handlePhone(String? value) {
    _phone = value;
    notifyListeners();
  }

  handlePassword(String? value) {
    _password = value;
    notifyListeners();
  }

  handleConfirmPassword(String? value) {
    _confirmPassword = value;
    notifyListeners();
  }

  register() {
    _navigationService.navigateTo(Routes.verifyEmailView);
  }
}
