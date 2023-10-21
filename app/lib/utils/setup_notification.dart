import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../enums/bottom_sheet_type.dart';
import '../models/contact.model.dart';
import '../models/instant_job.model.dart';
import '../models/post.model.dart';
import '../models/user.model.dart';
import '../models/notification.model.dart' as ModelNotification;
import '../services/authentication.service.dart';
import '../services/contact.service.dart';
import '../services/instant_job.service.dart';
import '../services/notification.service.dart';
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

List<ModelNotification.Notification>? get notifications =>
    _notificationService.notifications;
User? get currentUser => _authenticationService.currentUser;
List<InstantJob> get jobs => _instantJobService.instantJobs;
List<Post> get posts => _postService.posts;
List<Contact> get contacts => _contactService.contactList;

AndroidNotificationChannel androidChannelCall =
    const AndroidNotificationChannel(
  HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID, // id
  'handworker_call', // title
  importance: Importance.max,
  enableLights: true,
  playSound: true,
  sound: RawResourceAndroidNotificationSound('alert'),
);

AndroidNotificationChannel androidChannelMessage =
    const AndroidNotificationChannel(
  HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID, // id
  'handworker_message', // title
  importance: Importance.defaultImportance,
  enableLights: true,
  playSound: true,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupNotification(FirebaseMessaging messaging) async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('permission not granted. requesting ...');
  }

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          // onDidReceiveLocalNotification: onDidReceiveLocalNotification
          );
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: DarwinInitializationSettings(),
  );

  if (defaultTargetPlatform == TargetPlatform.android) {
    print('This is an android device');
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .createNotificationChannel(FirebaseMessagingHandler.androidChannelMessage);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(androidChannelMessage);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(androidChannelCall);
  }

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    print('ios permisssion result: $result');
  }

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    // onDidReceiveBackgroundNotificationResponse:
    //     onDidReceiveNotificationResponse,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification == null) return;

    _receiveNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen(onDidReceiveNotificationResponse);
}

void onDidReceiveNotificationResponse(RemoteMessage message) async {
  print('message: ${message.toMap()}');
  print('message notification: ${message.notification?.toMap()}');
  if (message.notification != null) {
    debugPrint('notification payload: ${message.toMap()}');
  }

  String entityId = message.data['entityId'];
  print('NOTIFICATION TYPE: ${message.data['notificationType']}');
  switch (message.data['notificationType']) {
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
    default:
      print("default notification");
      return;
  }
}

Future<void> _receiveNotification(RemoteMessage message) async {
  await _notificationService.getAccountNotifications(currentUser!.id!);
  print('defafult notifications');
  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    message.notification!.body.toString(),
    htmlFormatBigText: true,
    contentTitle: message.notification!.title.toString(),
    htmlFormatContent: true,
  );
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID,
    HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID,
    channelDescription: "",
    importance: Importance.max,
    styleInformation: bigTextStyleInformation,
    priority: Priority.max,
    playSound: true,
  );

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  print(
      'Message also contained a notification: ${message.notification?.toMap()}');
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  SheetResponse? _sheetResponse;
  if (message.data["callType"] != null) {
    List<Contact> contacts = await _contactService.getContacts();
    // print('contacts: ${contacts.map((e) => e.toJson()).toList()}');
    List<Contact> list = contacts
        .where((element) => element.id == message.data['callerId'])
        .toList();
    print('caller id: ${message.data["callerId"]}');

    await flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: message.data['title'],
    );
  }
}
