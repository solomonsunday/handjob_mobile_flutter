import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';

const String GOOGLE_AUTH = 'google_auth';
const String DEFAULT_AUTH = 'default_auth';

class CustomerSignupViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _tos = false;
  bool get tos => _tos;
  String? _tosError;
  String? get tosError => _tosError;
  // String? _username;
  // String? _accountType;
  // String? _email;
  // String? _phone;
  // String? _password;
  // String? _confirmPassword;
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;
  bool _formIsValid = false;
  bool _retypePasswordVisibility = true;
  // String? get username => _username;
  // String? get accountType => _accountType;
  // String? get email => _email;
  // String? get phone => _phone;
  // String? get password => _password;
  // String? get confirmPassword => _confirmPassword;
  bool get passwordVisibility => _passwordVisibility;
  bool get confirmPasswordVisibility => _confirmPasswordVisibility;
  bool get formIsValid => _formIsValid;
  bool get retypePasswordVisibility => _retypePasswordVisibility;

  togglePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  toggleRetypePasswordVisibility() {
    _retypePasswordVisibility = !_retypePasswordVisibility;
    notifyListeners();
  }

  toggleConfirmPasswordVisibility() {
    _confirmPasswordVisibility = !_confirmPasswordVisibility;
    notifyListeners();
  }

  setTos(bool value) {
    _tos = value;
    notifyListeners();
  }

  // handleAccountType(String? value) {
  //   _accountType = value;
  //   notifyListeners();
  // }

  // handleUsername(String? value) {
  //   _username = value;
  //   notifyListeners();
  // }

  // handleEmail(String? value) {
  //   _email = value;
  //   notifyListeners();
  // }

  // handlePhone(String? value) {
  //   _phone = value;
  //   notifyListeners();
  // }

  // handlePassword(String? value) {
  //   _password = value;
  // }

  // handleConfirmPassword(String? value) {
  //   _confirmPassword = value;
  // }

  void navigateToLogin() => _navigationService.navigateTo(Routes.authView);

  Future<void> register() async {
    runBusyFuture(registerRequest());
  }

  Future<void> registerRequest() async {
    try {
      setBusyForObject(DEFAULT_AUTH, true);
      var formData = {
        "email": emailValue,
        "password": passwordValue,
        "accountType": "Instant Hire",
        "firstName": firstnameValue,
        "lastName": lastnameValue,
      };
      // print('form data customer: $formData');
      await _authenticationService.createUser(formData);
      _navigationService.navigateTo(Routes.verifyEmailView,
          arguments: VerifyEmailViewArguments(email: emailValue!));
      Fluttertoast.showToast(
        msg: 'Account created!',
        toastLength: Toast.LENGTH_LONG,
      );
    } on DioError catch (error) {
      // throw Exception(error.response?.data["message"]);
      Fluttertoast.showToast(
        msg: error.response?.data["message"],
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      setBusyForObject(DEFAULT_AUTH, false);
      notifyListeners();
    }
  }

  Future<void> signUpWithGoogleAuth() async {
    runBusyFuture(
      signUpWithGoogleAuthRequest(),
    );
  }

  Future<void> signUpWithGoogleAuthRequest() async {
    setBusyForObject(GOOGLE_AUTH, true);
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      setBusyForObject(GOOGLE_AUTH, false);
    });
  }

  @override
  void setFormStatus() {
    // print('isFormValid: $_isFormValid');

    if (hasRetypePassword) {
      if (passwordValue != retypePasswordValue) {
        setRetypePasswordValidationMessage('Password mismatch');
        _formIsValid = false;
      }
    }

    _formIsValid = false;
    if (firstnameValue!.isNotEmpty &&
        lastnameValue!.isNotEmpty &&
        emailValue!.isNotEmpty &&
        phoneValue!.isNotEmpty &&
        passwordValue!.isNotEmpty) {
      _formIsValid = true;
    }

    print('form is valid: $isFormValid');
  }
}
