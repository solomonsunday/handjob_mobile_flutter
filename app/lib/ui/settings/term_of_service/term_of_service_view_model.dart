
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../app/app.locator.dart';

class TermOfServiceViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String _termsText = '';
  String get termsText => _termsText;
  final WebViewController webViewController = WebViewController();

  loadTextFromHtml() async {
    String content =
        await rootBundle.loadString('assets/terms_and_condition.html');
    print('content: $content');
    _termsText = content;
    notifyListeners();
  }

  // loadTextFromHtml() async {
  //   webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
  //   webViewController.enableZoom(true);
  //   webViewController.loadFlutterAsset('assets/terms_and_condition.html');
  // }

  // loadTextFromDocs() async {
  //   try {
  //     final bytes = await rootBundle.load('assets/terms_and_condition.docx');
  //     Uint8List docxBytes =
  //         bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  //     String content = docxToText(docxBytes);
  //     _termsText = content;
  //     notifyListeners();
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }

  void goBack() => _navigationService.back();
}
