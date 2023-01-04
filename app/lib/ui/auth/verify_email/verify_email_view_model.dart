import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/enums/dialog.enum.dart';
import 'package:handjob_mobile/ui/auth/verify_email/verify_email_view.form.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication.service.dart';

const String OTP_REQUEST = 'OTP_REQUEST';

class VerifyEmailViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  int? _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  int? get endTime => _endTime;

  showSuccessDialog() async {
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.ACCOUNT_CREATED);
    if (response!.confirmed) {
      _navigationService.navigateTo(Routes.mainView);
      await _authenticationService.getCurrentBaseUser();
    }
  }

  Future requestOTP(String email) async {
    try {
      setBusyForObject(OTP_REQUEST, true);
      var formData = {"email": email};
      await _authenticationService.requestOTP(formData);
      _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    } finally {
      setBusyForObject(OTP_REQUEST, false);
      notifyListeners();
    }
  }

  verifyOTP() async {
    try {
      setBusy(true);
      await _authenticationService.verifyOTP(otpCodeValue!);
      showSuccessDialog();
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
