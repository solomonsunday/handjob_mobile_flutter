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
import '../../services/contact.service.dart';
import '../../services/instant_job.service.dart';
import '../../app/app.locator.dart';
import '../../services/authentication.service.dart';

String REQUEST_OTP = "REQUEST_OTP";
String PROFILE_AVATAR_UPLOAD = "PROFILE_AVATAR_UPLOAD";

class ProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _sharedService = locator<SharedService>();
  final _accountService = locator<AccountService>();
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();
  final _contactService = locator<ContactService>();

  User? get currentUser => _authenticationService.currentUser;
  List<InstantJob> get instantHires => _instantJobService.instantHires;
  List<AppliedJob> get appliedJobs => _instantJobService.appliedJobs;
  int? get contactListCount => _contactService.contactListCount;

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

  void showVerifyPhoneSheet(dynamic data) =>
      _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.verify_phone_number,
        data: data,
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

  Future<void> fetchContactsCount() async {
    try {
      await _contactService.getContactsCount();
    } on DioError catch (e) {
    } finally {}
  }

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

  Future<void> uploadProfileAvatar() async {
    XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);
    if (xfile == null) return;

    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Do you really want to use this photo as your avatar?",
    );
    if (!response!.confirmed) return;

    setBusyForObject(PROFILE_AVATAR_UPLOAD, true);
    try {
      File file = File(xfile.path);
      await _accountService.uploadProfilePicture(file);
      await _authenticationService.getCurrentBaseUser();
    } on DioError catch (error) {
    } finally {
      setBusyForObject(PROFILE_AVATAR_UPLOAD, false);
      notifyListeners();
    }
  }

  handleOnSelectedInstantHire(InstantJob instantJob) =>
      _navigationService.navigateTo(
        Routes.applicationView,
        arguments: ApplicationViewArguments(
          instantJobId: instantJob.id!,
        ),
      );

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService, _contactService, _instantJobService];
}
