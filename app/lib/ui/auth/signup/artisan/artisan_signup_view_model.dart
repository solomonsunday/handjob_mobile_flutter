import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';
import '../customer/customer_signup_view_model.dart';

class ArtisanSignupViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool? _tos;

  var selectedProfession;
  bool? get tos => _tos;
  String? _profession;
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  String? get profession => _profession;
  bool get passwordVisibility => _passwordVisibility;
  bool get confirmPasswordVisibility => _confirmPasswordVisibility;

  List<String> get professions => ["Hello", "World"];

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

  void handleSelectedProfession(String? value) {
    _profession = value;
  }

  Future<void> register() async {
    runBusyFuture(registerRequest());
  }

  Future<void> registerRequest() async {
    try {
      setBusyForObject(DEFAULT_AUTH, true);
      var formData = {
        "email": emailValue,
        "password": passwordValue,
        "accountType": "Artisan",
        "profession": profession,
        "firstName": firstnameValue,
        "lastName": lastnameValue,
      };
      await _authenticationService.createUser(formData);
      _navigationService.navigateTo(Routes.verifyEmailView);
    } on DioError catch (error) {
      throw Exception(error.response?.data["message"]);
    } finally {
      setBusyForObject(DEFAULT_AUTH, false);
      notifyListeners();
    }
  }

  void navigateToLogin() => _navigationService.navigateTo(Routes.authView);

  bool _formIsValid = false;
  bool get formIsValid => _formIsValid;

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
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
