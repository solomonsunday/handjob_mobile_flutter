import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/main.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:peerdart/peerdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../services/notification.service.dart';
import '../../services/post.service.dart';
import '../../services/video-call.service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();
  final _postService = locator<PostService>();
  final _videoCallService = locator<VideoCallService>();
  final _notificationService = locator<NotificationService>();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  IO.Socket get videoSocket => _videoCallService.socket;

  int get currentIndex => _sharedService.currentIndex;

  User? get currentUser => _authenticationService.currentUser;

  navigateToProfile() => _navigationService.navigateTo(Routes.profileView);

  void initializeView() async {
    _videoCallService.initSocket();
    //update device token
    String? token = await messaging.getToken();
    if (token != null && currentUser != null) {
      // print("device registration token: $token");
      // print(" current user: ${currentUser?.toJson()}");
      Map formData = {
        "userId": currentUser?.id,
        "deviceToken": token,
        "platform": "mobile"
      };
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        formData['deviceName'] = info.device;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;
        formData['deviceName'] = info.name;
      } else {
        print('other devices');
        final info = await deviceInfo.deviceInfo;
        print('info json: ${info.data}');
      }
      print('formdata: $formData');
      try {
        await _authenticationService.updateDeviceToken(formData);
      } catch (e) {}
    }
  }

  @override
  dispose() {
    videoSocket.dispose();
    videoSocket.disconnect();
  }

  setCurrentIndex(int value) {
    _sharedService.setCurrentIndex(value);
    notifyListeners();
  }

  fetchPost() async {
    setBusy(true);
    try {
      await _postService.getPosts();
    } on DioError catch (error) {
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchCountries() async {
    try {
      await _sharedService.getCountries();
    } on DioError catch (error) {}
  }

  Future<void> fetchStates() async {
    try {
      await _sharedService.getStates();
    } on DioError catch (error) {}
  }

  Future<void> fetchLGA() async {
    try {
      await _sharedService.getLGA();
    } on DioError catch (error) {}
  }

  Future<void> fetchQualification() async {
    try {
      await _sharedService.getQualification();
    } on DioError catch (error) {}
  }

  Future<void> fetchProfessionTypes() async {
    try {
      await _sharedService.getProfessionTypes();
    } on DioError catch (error) {}
  }

  fetchNotification() async {
    try {
      await _notificationService.getNotifications();
    } on DioError catch (error) {}
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_sharedService];

  void navigateBack() => _navigationService.back();

  Future<void> logout() async {
    await _authenticationService.logout();
    _navigationService.replaceWith(Routes.authView);
  }

  void navigateToHelpAndSupport() =>
      _navigationService.navigateTo(Routes.helpAndSupportView);

  void navigateToFAQs() => _navigationService.navigateTo(Routes.fAQsView);

  void navigateToSettings() =>
      _navigationService.navigateTo(Routes.settingView);

  void navigateToContacts() =>
      _navigationService.navigateTo(Routes.contactView);

  void navigateToConnectionRequests() {}
}
