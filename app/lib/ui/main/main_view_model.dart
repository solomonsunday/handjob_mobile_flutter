import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';

class MainViewModel extends ReactiveViewModel {
  final _navigatorService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();

  int get currentIndex => _sharedService.currentIndex;

  User? get currentUser => _authenticationService.currentUser;

  navigateToProfile() => _navigatorService.navigateTo(Routes.profileView);

  setCurrentIndex(int value) {
    _sharedService.setCurrentIndex(value);
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_sharedService];
}
