import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/enums/bottom_sheet_type.dart';
import 'package:handjob_mobile/models/experience.model.dart';
import 'package:handjob_mobile/models/user.model.dart';
import 'package:handjob_mobile/services/experience.service.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../services/authentication.service.dart';

class ProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _sharedService = locator<SharedService>();

  User? get currentUser => _authenticationService.currentUser;

  TabController? tabController;

  goBack() => _navigationService.back();

  showServiceSheet() => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_service,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );

  showExperienceSheet(Experience? data) => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_experience,
        data: data,
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

  fetchStates() async {
    try {
      print('fetch states');
      await _sharedService.getStates();
    } on DioError catch (error) {
      throw Exception(error.response!.data["message"]);
    } finally {
      notifyListeners();
    }
  }

  fetchLGA(String stateId) async {
    try {
      print('fetch lga');
      await _sharedService.getLGA(stateId);
    } on DioError catch (error) {
      throw Exception(error.response!.data["message"]);
    } finally {
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authenticationService];
}
