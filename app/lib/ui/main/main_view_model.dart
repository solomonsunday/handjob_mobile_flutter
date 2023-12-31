import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/main.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/conversation.model.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../services/chat.service.dart';
import '../../services/notification.service.dart';
import '../../services/post.service.dart';
import '../../services/video-call.service.dart';

class MainViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();
  final _postService = locator<PostService>();
  // final _videoCallService = locator<VideoCallService>();
  final _dialogService = locator<DialogService>();
  final _notificationService = locator<NotificationService>();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final _chatService = locator<ChatService>();
  // IO.Socket get videoSocket => _videoCallService.socket;

  String _chatUnreadCount = '';
  int get currentIndex => _sharedService.currentIndex;

  User? get currentUser => _authenticationService.currentUser;

  String get chatUnreadCount => _chatUnreadCount;

  navigateToProfile() => _navigationService.navigateTo(Routes.profileView);

  void initializeView() async {
    // _videoCallService.initSocket();
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
    // videoSocket.dispose();
    // videoSocket.disconnect();
  }

  void getConversationList() async {
    setBusy(true);
    try {
      List<Conversation> conversations =
          await _chatService.getConversationList();
      int count = 0;
      for (var element in conversations) {
        print('element: ${element.toJson()}');
        count += element.unReadCount!;
      }
      _chatUnreadCount = '$count';
    } finally {
      setBusy(false);
    }
  }

  setCurrentIndex(int value) {
    _sharedService.setCurrentIndex(value);
    notifyListeners();
  }

  Future<void> fetchCountries() async {
    try {
      await _sharedService.getCountries();
    } on DioError {}
  }

  Future<void> fetchStates() async {
    try {
      await _sharedService.getStates();
    } on DioError {}
  }

  Future<void> fetchLGA() async {
    try {
      await _sharedService.getLGA();
    } on DioError {}
  }

  Future<void> fetchQualification() async {
    try {
      await _sharedService.getQualification();
    } on DioError {}
  }

  Future<void> fetchProfessionTypes() async {
    try {
      await _sharedService.getProfessionTypes();
    } on DioError {}
  }

  fetchPost() {
    runBusyFuture(
      fetchPostRequest(),
    );
  }

  fetchPostRequest() async {
    try {
      await _postService.getPosts();
    } finally {
      notifyListeners();
    }
  }

  fetchNotification() async {
    try {
      // await _notificationService.getNotifications();
      await _notificationService.getAccountNotifications(currentUser!.id!);
    } on DioError {}
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_sharedService];

  void navigateBack() => _navigationService.back();

  Future<void> logout() async {
    var response = await _dialogService.showConfirmationDialog(
        title: "Signing out",
        description: "Do you really want to logout?",
        confirmationTitle: 'Yes',
        cancelTitle: 'No');
    if (!response!.confirmed) return;
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

  // initialize zego cloud sdk
  final List<StreamSubscription> subscriptions = [];
  initZegoCloudSdk() async {
    // await ZEGOSDKManager.instance.init(ZEGO_APP_ID, ZEGO_APP_SIGNATURE);
    // String? token;
    // if (kIsWeb) {
    //   // ! ** Warning: ZegoTokenUtils is only for use during testing. When your application goes live,
    //   // ! ** tokens must be generated by the server side. Please do not generate tokens on the client side!
    //   token = ZegoTokenUtils.generateToken(
    //      ZEGO_APP_ID, ZEGO_SERVER_SECRET_KEY, currentUser?.id ?? "");
    // }
    // String name = '${currentUser?.firstName} ${currentUser?.lastName}';
    // print('current info ${currentUser?.id ?? ""}, $name, token: $ZEGO_TEMPORARY_TOKEN,');
    // await ZEGOSDKManager.instance.connectUser(
    //   currentUser?.id ?? "",
    //   name,
    //   token: ZEGO_TEMPORARY_TOKEN,
    // );

    // subscriptions.addAll([
    //   ZEGOSDKManager.instance.zimService.connectionStateStreamCtrl.stream
    //       .listen((ZIMServiceConnectionStateChangedEvent event) {
    //     debugPrint('connectionStateStreamCtrl: $event');
    //     if (event.state == ZIMConnectionState.connected) {
    //       print('ZIM connection state: $event');
    //     }
    //   }),
    // ]);
  }
}
