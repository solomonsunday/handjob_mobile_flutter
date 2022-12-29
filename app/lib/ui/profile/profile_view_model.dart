import 'package:flutter/material.dart';
import 'package:handjob_mobile/enums/bottom_sheet_type.dart';
import 'package:handjob_mobile/models/user.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../services/authentication.service.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  User? get currentUser => _authenticationService.currentUser;

  TabController? tabController;

  goBack() => _navigationService.back();

  showServiceSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.profile_service,
      isScrollControlled: true,
      ignoreSafeArea: true,
      enterBottomSheetDuration: Duration(milliseconds: 400),
      exitBottomSheetDuration: Duration(milliseconds: 200),
      enableDrag: true,
    );
  }

  showExperienceSheet() => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_experience,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );

  showEducationApprenticeSheet() => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_education,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );

  showContactSheet() => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_contact,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );

  void showVerifyPhoneSheet() => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.verify_phone_number,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );

  void showPortfolioSheet() => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_portfolio,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );
}
