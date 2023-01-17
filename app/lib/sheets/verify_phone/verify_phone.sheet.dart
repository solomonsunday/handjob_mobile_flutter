import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/services/account.service.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/sheets/verify_phone/verify_phone.sheet.form.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

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
      onModelReady: (model) => listenToFormUpdated(model),
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
                keyBoardType: TextInputType.number,
              ),
              SizedBox(height: AppSize.s24),
              DefaultButton(
                onPressed: model.verifyOTP,
                title: 'Verify',
                busy: model.isBusy,
                disabled: model.isBusy || !model.isFormValid,
              ),
            ],
          ),
        );
      },
    );
  }
}

class VerifyPhoneSheetViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _accountService = locator<AccountService>();

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  verifyOTP() {
    runBusyFuture(verifyOTPRequest());
  }

  verifyOTPRequest() async {
    try {
      await _accountService.verifySMSOTP(codeValue!);
    } on DioError catch (error) {
      throw HttpException(error.response?.data["message"] ?? "");
    } finally {
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
}
