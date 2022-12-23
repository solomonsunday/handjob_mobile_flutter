import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HelpAndSupportViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  goBack() => _navigationService.back();
}
