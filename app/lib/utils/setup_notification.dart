import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../models/instant_job.model.dart';
import '../models/post.model.dart';
import '../models/user.model.dart';
import '../models/notification.model.dart' as ModelNotification;
import '../services/authentication.service.dart';
import '../services/instant_job.service.dart';
import '../services/notification.service.dart';
import '../services/post.service.dart';
import 'contants.dart';

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
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    HANDJOB_NOTIFICATION_CHANNEL_ID, // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

// final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: DarwinInitializationSettings(),
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (defaultTargetPlatform == TargetPlatform.android) {
    print('This is an android device');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel);
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

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification?.toMap()}');
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContent: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        HANDJOB_NOTIFICATION_CHANNEL_ID,
        HANDJOB_NOTIFICATION_CHANNEL_ID,
        channelDescription: "",
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
        payload: message.data['title'],
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen(onDidReceiveNotificationResponse);
}

final _notificationService = locator<NotificationService>();
final _navigationService = locator<NavigationService>();
final _authenticationService = locator<AuthenticationService>();
final _postService = locator<PostService>();
final _instantJobService = locator<InstantJobService>();

List<ModelNotification.Notification>? get notifications =>
    _notificationService.notifications;
User? get currentUser => _authenticationService.currentUser;
List<InstantJob> get jobs => _instantJobService.instantJobs;
List<Post> get posts => _postService.posts;

void onDidReceiveNotificationResponse(RemoteMessage message) async {
  if (message != null) {
    debugPrint('notification payload: $message');
  }

  String entityId = message.data['entityId'];
  switch (message.data['notificationType']) {
    case 'instant_services':
      print('instant job type of noticiation  ');
      try {
        InstantJob job = jobs.where((element) {
          return element.id == entityId;
        }).first;
        print('job: ${job.toJson()}');
        _navigationService.navigateToJobDetailView(
          instantJob: job,
          user: currentUser!,
        );
      } catch (e) {
        print("error: $e");
      }
      break;
    case 'post':
      try {
        Post post = posts.where((element) => element.id == entityId).first;

        _navigationService.navigateToPostDetailView(post: post);
      } catch (e) {
        print('error: $e');
      }
      break;
    default:
      print("default notification");
      return;
  }
}
