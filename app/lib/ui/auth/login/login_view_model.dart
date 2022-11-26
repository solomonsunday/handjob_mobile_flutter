import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  String? _email;
  String? _password;
  bool _visibility = true;

  String? get email => _email;
  String? get password => _password;
  bool get visibility => _visibility;

  toggleVisibility() {
    _visibility = !_visibility;
    notifyListeners();
  }

  handleEmail(String? value) {
    _email = value;
    notifyListeners();
  }

  handlePassword(String? value) {
    _password = value;
    notifyListeners();
  }

  login() async {
    await runBusyFuture(loginTask());
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
      _navigationService.replaceWith(Routes.mainView);
      return response;
    } on DioError catch (err) {
      throw Exception(err.response!.data['message']);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}
