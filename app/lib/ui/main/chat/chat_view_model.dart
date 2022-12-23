import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class ChatViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<String> chats = [];
  void navigateBack() => _navigationService.back();

  handleSearch(String p1) {}

  void navigateToChatDetail() =>
      _navigationService.navigateTo(Routes.chatDetailView);
}
