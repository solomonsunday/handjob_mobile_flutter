import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../services/post.service.dart';
import '../../services/video-call.service.dart';

class MainViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();
  final _postService = locator<PostService>();
  final videoCallService = locator<VideoCallService>();

  int get currentIndex => _sharedService.currentIndex;

  User? get currentUser => _authenticationService.currentUser;

  navigateToProfile() => _navigationService.navigateTo(Routes.profileView);

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
