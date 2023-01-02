import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  recoverPassword() {}

  void navigateToLogin() => _navigationService.navigateTo(Routes.authView);
}
