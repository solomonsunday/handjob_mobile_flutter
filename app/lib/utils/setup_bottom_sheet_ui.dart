import 'package:handjob_mobile/sheets/edit_instant_job/edit_instant_job_sheet_view.dart';
import 'package:handjob_mobile/sheets/incoming_call/incoming_call_view.dart';
import 'package:handjob_mobile/sheets/ongoing_video_call/ongoing_video_call_view.dart';
import 'package:handjob_mobile/sheets/ongoing_voice_call/ongoing_voice_call_view.dart';
import 'package:handjob_mobile/sheets/outgoing_call/outgoing_call_view.dart';
import 'package:handjob_mobile/sheets/profile_contact/profile_contact.sheet.dart';
import 'package:handjob_mobile/sheets/profile_education/profile_education.sheet.dart';
import 'package:handjob_mobile/sheets/profile_experience/profile_experience.sheet.dart';
import 'package:handjob_mobile/sheets/profile_portfolio/profile_portfolio.sheet.dart';
import 'package:handjob_mobile/sheets/profile_service.sheet.dart';
import 'package:handjob_mobile/sheets/verify_phone/verify_phone.sheet.dart';
import 'package:stacked_services/stacked_services.dart';

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
    BottomSheetType.incoming_call: (context, sheetRequest, completer) =>
        IncomingCallView(request: sheetRequest, completer: completer),
    BottomSheetType.outgoing_call: (context, sheetRequest, completer) =>
        OutgoingCallView(request: sheetRequest, completer: completer),
    BottomSheetType.ongoing_voice_call: (context, sheetRequest, completer) =>
        OngoingVoiceCallView(request: sheetRequest, completer: completer),
    // BottomSheetType.ongoing_video_call: (context, sheetRequest, completer) =>
    //     OngoingVideoCallView(request: sheetRequest, completer: completer),
    BottomSheetType.edit_instant_job: (context, sheetRequest, completer) =>
        EditInstantJobSheetView(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
