import 'package:dio/dio.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/ui/help_and_support/help_and_support_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HelpAndSupportViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  goBack() => _navigationService.back();

  void sendMessage() async {
    if (titleValue == null && messageValue == null) {
      _dialogService.showDialog(
          description: "All fields are required!", title: "Validation error");
      return;
    }
    setBusy(true);

    var request = {
      'title': titleValue ?? "",
      'message': messageValue ?? "",
    };
    print('request body: $request');
    // email
    try {
      final Email email = Email(
        body: messageValue ?? "",
        subject: titleValue ?? "",
        recipients: ['handworkerteam@gmail.com'],
        cc: [],
        bcc: [],
        attachmentPaths: [],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } on DioError catch (e) {
      _dialogService.showDialog(
        description: 'Email error: ${e.message}',
        title: 'Error sending message',
      );
    } finally {
      setBusy(false);
    }
  }
}
