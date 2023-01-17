import 'package:handjob_mobile/sheets/profile_contact/profile_contact.sheet.dart';
import 'package:handjob_mobile/sheets/profile_education/profile_education.sheet.dart';
import 'package:handjob_mobile/sheets/profile_experience/profile_experience.sheet.dart';
import 'package:handjob_mobile/sheets/profile_portfolio.sheet.dart';
import 'package:handjob_mobile/sheets/profile_service.sheet.dart';
import 'package:handjob_mobile/sheets/verify_phone/verify_phone.sheet.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

import '../app/app.locator.dart';
import '../enums/bottom_sheet_type.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.profile_service: (context, sheetRequest, completer) =>
        ProfileServiceSheet(request: sheetRequest, completer: completer),
    BottomSheetType.profile_experience: (context, sheetRequest, completer) =>
        ProfileExperienceSheet(request: sheetRequest, completer: completer),
    BottomSheetType.profile_education: (context, sheetRequest, completer) =>
        ProfileEducationSheet(request: sheetRequest, completer: completer),
    BottomSheetType.profile_contact: (context, sheetRequest, completer) =>
        ProfileContactSheet(request: sheetRequest, completer: completer),
    BottomSheetType.verify_phone_number: (context, sheetRequest, completer) =>
        VerifyPhoneSheet(request: sheetRequest, completer: completer),
    BottomSheetType.profile_portfolio: (context, sheetRequest, completer) =>
        ProfilePortfolioSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
