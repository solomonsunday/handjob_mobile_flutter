import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/notification.model.dart'
    as NotificationModel;
import 'package:handjob_mobile/ui/contact/contact_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../app/app.locator.dart';
import '../../models/contact.model.dart';
import '../../models/instant_job.model.dart';
import '../../models/post.model.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../services/contact.service.dart';
import '../../services/instant_job.service.dart';
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
      onViewModelReady: (model) async {
        await model.getNotification();
      },
      builder: (_, model, child) => Scaffold(
        appBar: Navbar(
          leadingIcon: const Icon(
            Icons.arrow_back,
            color: ColorManager.kDarkColor,
          ),
          onTap: model.navigateBack,
          title: "Notifications",
          fontsize: FontSize.s16,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if ((model.notifications ?? []).isEmpty)
                Container(
                  child: Text(
                    'No notification available yet!',
                    style: getMediumStyle(
                      color: ColorManager.kDarkCharcoal,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
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
      onViewModelReady: (model) async {
        if (!notification.seen!) {
          await model.updateSeenNotification(notification.id!);
        }
      },
      builder: (context, model, child) => ListTile(
        onTap: () async {
          model.navigateNotification(notification);
          // print(
          //     'notification seen: ${notification.message} ${notification.id}');
          if (!notification.seen!) {
            await model.updateSeenNotification(notification.id!);
          }
        },
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
  final _instantJobService = locator<InstantJobService>();
  final _contactService = locator<ContactService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  List<Post> get posts => _postService.posts;
  List<InstantJob> get jobs => _instantJobService.instantJobs;
  User? get currentUser => _authenticationService.currentUser;
  List<Contact> get connectionRequestList =>
      _contactService.connectionRequestList;

  updateSeenNotification(String id) async {
    try {
      await _notificationService.updateSeenNotification(id);
    } catch (e) {}
  }

  navigateNotification(NotificationModel.Notification notification) {
    // print(
    //     'notification: ${notification.notificationType} ${notification.toJson()}');
    switch (notification.notificationType) {
      case 'instant_services':
        print('instant job type of noticiation  ');

        _navigationService.navigateToNotificationJobDetailView(
          instantJobId: notification.entityId!,
          user: currentUser!,
        );

        break;
      case 'post':
        try {
          Post post = posts
              .where((element) => element.id == notification.entityId)
              .first;

          _navigationService.navigateToPostDetailView(post: post, postIndex: 0);
        } catch (e) {
          print('error: $e');
        }
        break;
      case 'contact_request':
        _navigationService.navigateToContactView(
          activeTab: CONNECTION_REQUEST_TAB,
        );

        break;
      default:
        _dialogService.showDialog(
          description: notification.message,
          title: notification.notificationType,
        );
        print("default notification: ${notification.toJson()}");
        return;
    }
  }
}

/**
 * export enum notificationTopics {
  JOB = 'job',
  CONNECTION_REQUEST = 'connection',
  POST = 'post',
  APPLICATION = 'application',
  REVIEW = 'review',
  CHAT = 'chat'
}
 */
