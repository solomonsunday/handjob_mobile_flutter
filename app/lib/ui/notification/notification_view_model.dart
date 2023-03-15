import 'dart:ffi';

import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../models/notification.model.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../services/notification.service.dart';

class NotificationViewModel extends ReactiveViewModel {
  final _notificationService = locator<NotificationService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  List<Notification>? get notifications => _notificationService.notifications;
  User? get currentUser => _authenticationService.currentUser;

  getNotification() async {
    try {
      await _notificationService.getNotifications();
      // await _notificationService.getAccountNotifications(currentUser!.id!);
    } catch (e) {}
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_notificationService];

  void navigateBack() => _navigationService.back();
}
