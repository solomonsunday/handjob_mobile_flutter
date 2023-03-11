import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../models/notification.model.dart';
import '../../services/notification.service.dart';

class NotificationViewModel extends ReactiveViewModel {
  final _notificationService = locator<NotificationService>();

  List<Notification>? get notifications => _notificationService.notifications;

  getNotification() async {
    try {
      await _notificationService.getNotifications();
    } catch (e) {}
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_notificationService];
}
