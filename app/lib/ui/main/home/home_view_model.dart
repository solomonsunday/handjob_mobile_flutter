import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();

  void onPostImageClick() {
    _navigationService.navigateTo(Routes.postDetailView);
  }

  void navigateToNotification() {}
}
