import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/services/account.service.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/sheets/verify_phone/verify_phone.sheet.form.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../models/user.model.dart';

@FormView(fields: [FormTextField(name: 'code')])
class VerifyPhoneSheet extends StatelessWidget with $VerifyPhoneSheet {
  VerifyPhoneSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyPhoneSheetViewModel>.reactive(
      viewModelBuilder: () => VerifyPhoneSheetViewModel(),
      onModelReady: (model) {
        listenToFormUpdated(model);

        if (request?.data != null) {
          User user = request?.data as User;
          model.setCurrentUser(user);
        }
      },
      onDispose: (model) => disposeForm(),
      builder: (context, model, child) {
        return BottomSheetContainer(
          onClose: () => completer!(SheetResponse(confirmed: false)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Verify phone number'),
                ],
              ),
              const SizedBox(height: AppSize.s24),
              const Text('Enter the code that was sent to your phone number'),
              const SizedBox(height: AppSize.s12),
              InputField(
                hintText: 'Enter verification code',
                fillColor: ColorManager.kWhiteColor,
                controller: codeController,
                focusnode: codeFocusNode,
                keyBoardType: TextInputType.text,
              ),
              SizedBox(height: AppSize.s24),
              DefaultButton(
                onPressed: () => model.verifyOTP(completer),
                title: 'Verify',
                busy: model.isBusy,
                disabled: model.isBusy || !model.isFormValid,
              ),
              SizedBox(height: AppSize.s16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async => await model.requestOTP(),
                    child: CountdownTimer(
                        endTime: model.endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text(
                              model.busy(SMS_OTP_REQUEST)
                                  ? 'Resending code...'
                                  : 'Resend code',
                              style: getBoldStyle(
                                color: ColorManager.kDarkColor,
                                fontSize: FontSize.s11,
                              ),
                            );
                          }
                          return Text('Retry.. ${time.min ?? 00}:${time.sec}');
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

const String SMS_OTP_REQUEST = 'SMS_OTP_REQUEST';

class VerifyPhoneSheetViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _accountService = locator<AccountService>();

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  User? _user;
  User? get user => _user;

  int? _endTime =
      DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 5; // 5minutes
  int? get endTime => _endTime;

  verifyOTP(completer) {
    runBusyFuture(verifyOTPRequest(completer));
  }

  verifyOTPRequest(completer) async {
    try {
      await _accountService.verifySMSOTP(codeValue!);
      completer!(SheetResponse(
        confirmed: true,
      ));
    } on DioError catch (error) {
      throw HttpException(error.response?.data["message"] ?? "");
    } finally {
      _authenticationService.getCurrentBaseUser();
      notifyListeners();
    }
  }

  Future requestOTP() async {
    try {
      setBusyForObject(SMS_OTP_REQUEST, true);
      var formData = {"phone": user?.phoneNumber};
      await _accountService.requestSMSOTP(user!.phoneNumber!, user!.id!);
      _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 5;
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    } finally {
      setBusyForObject(SMS_OTP_REQUEST, false);
      notifyListeners();
    }
  }

  @override
  void setFormStatus() {
    print('form status: $codeValue $_isFormValid');
    if (codeValue == "") {
      _isFormValid = false;
      print('form status valid: $_isFormValid');
      return;
    }
    print('form status finalle: $_isFormValid');
    _isFormValid = true;
  }

  void setCurrentUser(User user) {
    _user = user;
  }
}
