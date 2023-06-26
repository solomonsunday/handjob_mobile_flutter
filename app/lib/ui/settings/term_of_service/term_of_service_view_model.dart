import 'dart:io';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class TermOfServiceViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String _termsText = '';
  String get termsText => _termsText;

  loadTextFromDocs() async {
    try {
      final bytes = await rootBundle.load('assets/terms_and_condition.docx');
      Uint8List docxBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      String content = docxToText(docxBytes);
      _termsText = content;
      notifyListeners();
    } catch (e) {
      print('error: $e');
    }
  }

  void goBack() => _navigationService.back();
}
