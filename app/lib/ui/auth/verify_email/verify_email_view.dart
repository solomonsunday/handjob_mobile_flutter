import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/ui/auth/verify_email/verify_email_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import 'verify_email_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'otpCode'),
])
class VerifyEmailView extends StatelessWidget with $VerifyEmailView {
  VerifyEmailView({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>.reactive(
      viewModelBuilder: () => VerifyEmailViewModel(),
      onViewModelReady: (model) {
        syncFormWithViewModel(model);
        Future.delayed(Duration.zero, () {
          otpCodeController.clear();
          //your code goes here
        });
      },
      onDispose: (_) => disposeForm(),
      builder: (context, model, _) => Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Verify your e-mail',
                    style: getSemiBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  const SizedBox(height: AppSize.s56),
                  SvgPicture.asset(
                    'assets/images/verify_email_icon.svg',
                    width: 143,
                    height: 143,
                  ),
                  const SizedBox(height: AppSize.s24),
                  RichText(
                    text: TextSpan(
                      text:
                          'To finish your registration, please enter the verification code we sent to ',
                      children: [
                        TextSpan(
                          text: email,
                          style: getBoldStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s14,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' It might take a few seconds to receive your code.',
                        ),
                      ],
                      style: getRegularStyle(
                        color: ColorManager.kDarkColor,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSize.s56),
                  InputField(
                    hintText: 'Enter verification code',
                    controller: otpCodeController,
                    fillColor: ColorManager.kWhiteColor,
                    keyBoardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSize.s16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async => await model.requestOTP(email),
                        child: CountdownTimer(
                            endTime: model.endTime,
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              if (time == null) {
                                return Text(
                                  model.busy(OTP_REQUEST)
                                      ? 'Resending code...'
                                      : 'Resend code',
                                  style: getBoldStyle(
                                    color: ColorManager.kDarkColor,
                                    fontSize: FontSize.s11,
                                  ),
                                );
                              }
                              return Text(
                                  'Retry.. ${time.min ?? 00}:${time.sec}');
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s32),
                  DefaultButton(
                    onPressed: model.verifyOTP,
                    title: 'Submit',
                    buttonBgColor: ColorManager.kDarkColor,
                    borderRadius: AppSize.s12,
                    busy: model.isBusy,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
