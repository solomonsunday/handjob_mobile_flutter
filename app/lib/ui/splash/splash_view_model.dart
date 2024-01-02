import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../utils/contants.dart';

class SplashViewViewModel extends BaseViewModel {
  final log = getLogger('SplashViewModel');
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  void navigateToOnboard() async =>
      await _navigationService.replaceWith(Routes.onboardView);
  void navigateToLogin() => _navigationService.replaceWith(Routes.authView);
  // void navigateToSignup() => _navigationService.replaceWith(Routes.signupView);
  bool _isLoggedIn = true;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> getCurrentUserRequest() async {
    log.i('initializing...');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isFirstTimeUser = preferences.getBool(IS_FIRST_TIME_USER);
    if (isFirstTimeUser == null || isFirstTimeUser) {
      navigateToOnboard();
      return;
    }

    // bool authResponse = await _authenticationService.isAuthenticated();
    // if (authResponse) {
    //   await _authenticationService.getCurrentBaseUser();
    //   _navigationService.replaceWith(Routes.mainView);
    //   return;
    // }

    // navigateToLogin();

    // return;
    try {
      bool authResponse = await _authenticationService.isAuthenticated();
      if (authResponse) {
        _isLoggedIn = true;
      } else {
        _isLoggedIn = false;
      }

      // return authResponse;
    } on DioError {
      _isLoggedIn = false;
      // throw Exception(error.response?.data["message"]);
      bool? isFirstTimeUser = preferences.getBool(IS_FIRST_TIME_USER);
      if (isFirstTimeUser == null || isFirstTimeUser) {
        navigateToOnboard();
      } else {
        navigateToLogin();
      }
    } finally {
      // Future.delayed(const Duration(seconds: 2), () async {

      // });
      if (_isLoggedIn) {
        try {
          User user = await _authenticationService.getCurrentBaseUser();

          _navigationService.replaceWith(Routes.mainView);
        } catch (e) {
          navigateToLogin();
          print(
            'An error occured: $e',
          );
        }
      } else {
        bool? isFirstTimeUser = preferences.getBool(IS_FIRST_TIME_USER);
        if (isFirstTimeUser == null || isFirstTimeUser) {
          navigateToOnboard();
        } else {
          navigateToLogin();
        }
      }
    }
    return;
  }

  Future<void> getCurrentUser() async {
    await runBusyFuture(getCurrentUserRequest());
  }

  @override
  void onError(error) {
    log.e(error);
  }
}
