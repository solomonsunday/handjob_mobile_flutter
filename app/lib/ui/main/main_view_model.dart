import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';

class MainViewModel extends IndexTrackingViewModel {
  final _navigatorService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;

  navigateToProfile() => _navigatorService.navigateTo(Routes.profileView);
}
