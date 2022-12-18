import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/user.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../services/authentication.service.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;

  TabController? tabController;

  goBack() => _navigationService.back();
}
