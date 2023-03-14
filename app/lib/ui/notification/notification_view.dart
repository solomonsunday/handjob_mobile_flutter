import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/notification.model.dart'
    as NotificationModel;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../app/app.locator.dart';
import '../../models/post.model.dart';
import '../../services/notification.service.dart';
import '../../services/post.service.dart';
import '../../utils/helpers.dart';
import 'notification_view_model.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) async {
        await model.getNotification();
      },
      builder: (_, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (model.notifications == null) Container(),
              Expanded(
                child: ListView.builder(
                  itemCount: (model.notifications ?? []).length,
                  itemBuilder: (_, index) {
                    NotificationModel.Notification notification =
                        model.notifications![index];
                    return NotificationItem(notification: notification);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
  });
  final NotificationModel.Notification notification;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationItemViewModel>.reactive(
      viewModelBuilder: () => NotificationItemViewModel(),
      onModelReady: (model) async {
        if (!notification.seen!) {
          await model.updateSeenNotification(notification.id!);
        }
      },
      builder: (context, model, child) => ListTile(
        onTap: () => model.navigateNotification(notification),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p24,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${notification.createdBy}',
              style: getBoldStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s12,
              ),
            ),
            const SizedBox(width: AppSize.s12),
            Text(
              '${notification.message}',
              style: getRegularStyle(
                color: ColorManager.kGrey4,
                fontSize: FontSize.s11,
              ),
            )
          ],
        ),
        subtitle: Text(
          getTimeAgoDiff(notification.createdAt!),
          style: getRegularStyle(
            color: ColorManager.kGrey4,
            fontSize: FontSize.s11,
          ),
        ),
      ),
    );
  }
}

class NotificationItemViewModel extends BaseViewModel {
  final _notificationService = locator<NotificationService>();
  final _navigationService = locator<NavigationService>();
  final _postService = locator<PostService>();

  List<Post> get posts => _postService.posts;

  updateSeenNotification(String id) async {
    try {
      await _notificationService.updateSeenNotification(id);
    } catch (e) {}
  }

  navigateNotification(NotificationModel.Notification notification) {
    switch (notification.notificationType) {
      case 'instant_services':
        print('instant job type of noticiation');
        break;
      case 'post':
        Post post =
            posts.where((element) => element.id == notification.entityId).first;

        _navigationService.navigateToPostDetailView(post: post);
        break;
      default:
        print("default notification");
        return;
    }
  }
}
