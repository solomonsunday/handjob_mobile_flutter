import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class ContactViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  handleSearch(String p1) {}

  void goBack() => _navigationService.back();
}
