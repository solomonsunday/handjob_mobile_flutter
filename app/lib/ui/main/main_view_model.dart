import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class MainViewModel extends IndexTrackingViewModel {
  final _navigatorService = locator<NavigationService>();

  navigateToProfile() => _navigatorService.navigateTo(Routes.profileView);
}
