import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../models/contact.model.dart';
import '../models/instant_job.model.dart';
import '../models/post.model.dart';
import '../models/user.model.dart';
import '../services/authentication.service.dart';
import '../services/contact.service.dart';
import '../services/instant_job.service.dart';
import '../services/post.service.dart';
import '../services/video-call.service.dart';
import 'contants.dart';

final _notificationService = locator<NotificationService>();
final _navigationService = locator<NavigationService>();
final _authenticationService = locator<AuthenticationService>();
final _postService = locator<PostService>();
final _instantJobService = locator<InstantJobService>();
final _bottomSheetService = locator<BottomSheetService>();
final _contactService = locator<ContactService>();
final _videoCallService = locator<VideoCallService>();

User? get currentUser => _authenticationService.currentUser;
List<InstantJob> get jobs => _instantJobService.instantJobs;
List<Post> get posts => _postService.posts;
List<Contact> get contacts => _contactService.contactList;

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod: $receivedAction');
    String buttonKeyPressed = receivedAction.buttonKeyPressed;
    final message = receivedAction.payload;

    print('message: $message');
    print('message data: ${message!['data']}');
    print('message notification: ${message['notification']}');

    String entityId = message['entityId']!;
    print('NOTIFICATION TYPE: ${message['notificationType']}');
    switch (message['notificationType']) {
      case 'instant_services':
        if (currentUser?.accountType == ACCOUNT_ARTISAN) {
          _navigationService.navigateToApplicationView(instantJobId: entityId);
        } else {
          _navigationService.navigateToNotificationJobDetailView(
            instantJobId: entityId,
            user: currentUser!,
          );
        }
        break;
      case 'post':
        try {
          Post post = posts.where((element) => element.id == entityId).first;

          _navigationService.navigateToPostDetailView(post: post, postIndex: 0);
        } catch (e) {
          print('error: $e');
        }
        break;
      case 'voice':
      case 'video':
        print('this is voice/video call');

        List<Contact> contacts = await _contactService.getContacts();
        List<Contact> list = contacts
            .where((element) => element.id == message['callerId'])
            .toList();
        if (list.isEmpty) {
          print('no contact found');
          return;
        }
        Contact contact = list.first;
        print('contact found: ${contact.toJson()}');
        if (message['callType'] == "end_call") {
          print('end caller call');
          _videoCallService.agoraEngine.leaveChannel();
          _navigationService.back();
        }
        if (buttonKeyPressed == 'reject') {
          await _videoCallService.sendNotification({
            "callType": "end_call",
            "callId": contact.id,
            "callName": '${contact.firstName} ${contact.lastName}',
            "callerId": '${currentUser?.id}',
            "callerName": '${currentUser?.firstName} ${currentUser?.lastName}',
            "callRole": "audience",
            "notificationType": 'video'
          });
          await AwesomeNotifications().cancelAll();
          print('reject call');
        } else {
          print('call accepted and nanvigate');
          _navigationService.navigateToOngoingVideoCallView(
            contact: contact,
            callRole: 'audience',
          );
          // _bottomSheetService.showCustomSheet(
          //   variant: BottomSheetType.ongoing_video_call,
          //   isScrollControlled: true,
          //   data: {
          //     'contact': contact.toJson(),
          //     'call_role': 'audience',
          //   },
          // );
        }

        break;
      default:
        print("default notification");
        return;
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
