import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';

class SplashViewViewModel extends BaseViewModel {
  final log = getLogger('MyViewModel');
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToOnboard() async =>
      await _navigationService.replaceWith(Routes.onboardView);
  void navigateToLogin() => _navigationService.replaceWith(Routes.authView);
  // void navigateToSignup() => _navigationService.replaceWith(Routes.signupView);
  bool _isLoggedIn = true;
  bool get isLoggedIn => _isLoggedIn;

  Future<User?> getCurrentUserRequest() async {
    log.i('');
    try {
      var response = await _authenticationService.getCurrentBaseUser();
      // if (response == null) {
      //   log.i('Success Profile ${response.role}');
      //   switch (response.role) {
      //     case "MERCHANT":
      //     case "ADMIN":
      //     case "SUPERADMIN":
      //       break;
      //   }
      // }
      _isLoggedIn = true;

      return response;
    } on DioError catch (error) {
      print('error: ${error.response?.data}');
      _isLoggedIn = false;
      throw Exception(error.response?.data["message"]);
    } finally {
      print('done');
      if (_isLoggedIn) {
        _navigationService.replaceWith(Routes.mainView);
      } else {
        navigateToOnboard();
      }
    }
  }

  Future<void> getCurrentUser() async {
    await runBusyFuture(getCurrentUserRequest());
  }

  @override
  void onError(error) {
    log.e(error);
  }
}
