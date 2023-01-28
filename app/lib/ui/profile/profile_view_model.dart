import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/enums/bottom_sheet_type.dart';
import 'package:handjob_mobile/models/experience.model.dart';
import 'package:handjob_mobile/models/user.model.dart';
import 'package:handjob_mobile/services/account.service.dart';
import 'package:handjob_mobile/services/experience.service.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../models/applied_job.model.dart';
import '../../models/instant_job.model.dart';
import '../../services/instant_job.service.dart';
import '../../app/app.locator.dart';
import '../../services/authentication.service.dart';

String REQUEST_OTP = "REQUEST_OTP";

class ProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _sharedService = locator<SharedService>();
  final _accountService = locator<AccountService>();
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();

  User? get currentUser => _authenticationService.currentUser;
  List<InstantJob> get instantHires => _instantJobService.instantHires;
  List<AppliedJob> get appliedJobs => _instantJobService.appliedJobs;

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

  showContactSheet(dynamic data) => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_contact,
        data: data,
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
      throw Exception(error.response?.data["message"] ?? "");
    } finally {
      notifyListeners();
    }
  }

  fetchAppliedJobs() async {
    try {
      await _instantJobService.getAppliedJobs();
    } on DioError catch (error) {
      throw Exception(error.response?.data["message"] ?? "");
    } finally {
      notifyListeners();
    }
  }

  fetchInstantHires() async {
    try {
      await _instantJobService.getInstantJobs();
    } on DioError catch (error) {
      throw Exception(error.response!.data["message"]);
    } finally {
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authenticationService];

  Future<void> requestOTP() async {
    runBusyFuture(requestOTPRequest(), busyObject: REQUEST_OTP);
  }

  Future<void> requestOTPRequest() async {
    var formData = {"email": currentUser?.email};
    try {
      await _authenticationService.requestOTP(formData);
      await _accountService.requestSMSOTP(
          currentUser!.phoneNumber!, currentUser!.id!);
    } on DioError catch (e) {
      throw HttpException(e.response?.data ?? "");
    } finally {
      notifyListeners();
    }
  }

  final ImagePicker _picker = ImagePicker();

  void uploadProfileAvatar() async {
    XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);
    if (xfile == null) return;

    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Do you really want to use this photo as your avatar?",
    );
    if (!response!.confirmed) return;

    try {
      File file = File(xfile.path);
      await _accountService.uploadProfilePicture(file);
      await _authenticationService.getCurrentBaseUser();
    } on DioError catch (error) {}
  }

  handleOnSelectedInstantHire(InstantJob instantJob) =>
      _navigationService.navigateTo(
        Routes.applicationView,
        arguments: ApplicationViewArguments(
          instantHire: instantJob,
        ),
      );
}
