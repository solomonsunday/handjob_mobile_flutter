import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:handjob_mobile/utils/setup_awesome_notification.dart';
import 'package:ui_package/utils/colors.dart';

import '../app/app.locator.dart';
import '../models/contact.model.dart';
import '../services/contact.service.dart';
import 'contants.dart';

final _contactService = locator<ContactService>();

void showNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Just show awesome notification');
    print('Message data: ${message.data}');
    if (message.notification == null) return;
    if (message.data["callType"] != null) {
      List<Contact> contacts = await _contactService.getContacts();
      print('contacts: ${contacts.map((e) => e.toJson()).toList()}');
      List<Contact> list = contacts
          .where((element) => element.id == message.data['callerId'])
          .toList();
      print('caller id: ${message.data["callerId"]}');

      if (list.isNotEmpty) {
        if (message.data["callType"] == VOICE_CALL ||
            message.data["callType"] == VIDEO_CALL) {
          //show any type of notification ...
          Contact contact = list.first;
          print('contact found: ${contact.toJson()}');

          if (message.data["callType"] == VOICE_CALL ||
              message.data["callType"] == VIDEO_CALL) {
            await NotificationService.showNotification(
                title: 'Incoming call ',
                body: '${contact.firstName} ${contact.lastName} is calling...',
                payload: {
                  'callType': message.data["callType"],
                  'entityId': message.data["entityId"],
                  "notificationType": message.data["notificationType"],
                  "callerId": message.data["callerId"],
                },
                actionButtons: [
                  NotificationActionButton(
                    key: 'reject',
                    label: 'Reject',
                    color: ColorManager.kRed,
                    actionType: ActionType.SilentAction,
                  ),
                  NotificationActionButton(
                    key: 'accept',
                    label: 'Accept',
                    color: ColorManager.kGreen,
                    actionType: ActionType.Default,
                  ),
                ]);
            return;
          }
        }
      }
    } else {
      //any notification other than call...
      await NotificationService.showNotification(
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
      );
    }
  });
}
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:handjob_mobile/app/app.router.dart';
// import 'package:stacked_services/stacked_services.dart';

// import '../app/app.locator.dart';
// import '../enums/bottom_sheet_type.dart';
// import '../models/contact.model.dart';
// import '../models/instant_job.model.dart';
// import '../models/post.model.dart';
// import '../models/user.model.dart';
// import '../models/notification.model.dart' as ModelNotification;
// import '../services/authentication.service.dart';
// import '../services/contact.service.dart';
// import '../services/instant_job.service.dart';
// import '../services/notification.service.dart';
// import '../services/post.service.dart';
// import '../services/video-call.service.dart';
// import 'contants.dart';

// final _notificationService = locator<NotificationService>();
// final _navigationService = locator<NavigationService>();
// final _authenticationService = locator<AuthenticationService>();
// final _postService = locator<PostService>();
// final _instantJobService = locator<InstantJobService>();
// final _bottomSheetService = locator<BottomSheetService>();
// final _contactService = locator<ContactService>();
// final _videoCallService = locator<VideoCallService>();

// List<ModelNotification.Notification>? get notifications =>
//     _notificationService.notifications;
// User? get currentUser => _authenticationService.currentUser;
// List<InstantJob> get jobs => _instantJobService.instantJobs;
// List<Post> get posts => _postService.posts;
// List<Contact> get contacts => _contactService.contactList;

// AndroidNotificationChannel androidChannelCall =
//     const AndroidNotificationChannel(
//   HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID, // id
//   'handworker_call', // title
//   importance: Importance.max,
//   enableLights: true,
//   playSound: true,
//   sound: RawResourceAndroidNotificationSound('alert'),
// );

// AndroidNotificationChannel androidChannelMessage =
//     const AndroidNotificationChannel(
//   HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID, // id
//   'handworker_message', // title
//   importance: Importance.defaultImportance,
//   enableLights: true,
//   playSound: true,
// );

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> setupNotification(FirebaseMessaging messaging) async {
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print('User granted provisional permission');
//   } else {
//     print('permission not granted. requesting ...');
//   }

//   const DarwinInitializationSettings initializationSettingsDarwin =
//       DarwinInitializationSettings(
//           // onDidReceiveLocalNotification: onDidReceiveLocalNotification
//           );
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/launcher_icon');
//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: DarwinInitializationSettings(),
//   );

//   if (defaultTargetPlatform == TargetPlatform.android) {
//     print('This is an android device');
//     // await flutterLocalNotificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()!
//     //     .createNotificationChannel(FirebaseMessagingHandler.androidChannelMessage);
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .createNotificationChannel(androidChannelMessage);
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .createNotificationChannel(androidChannelCall);
//   }

//   if (defaultTargetPlatform == TargetPlatform.iOS) {
//     final bool? result = await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     print('ios permisssion result: $result');
//   }

//   flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     // onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     // onDidReceiveBackgroundNotificationResponse:
//     //     onDidReceiveNotificationResponse,
//   );

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');
//     if (message.notification == null) return;

//     _receiveNotification(message);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen(onDidReceiveNotificationResponse);
// }

// void onDidReceiveNotificationResponse(RemoteMessage message) async {
// print('message: ${message.toMap()}');
// print('message notification: ${message.notification?.toMap()}');
// if (message.notification != null) {
//   debugPrint('notification payload: ${message.toMap()}');
// }

// String entityId = message.data['entityId'];
// print('NOTIFICATION TYPE: ${message.data['notificationType']}');
// switch (message.data['notificationType']) {
//   case 'instant_services':
//     if (currentUser?.accountType == ACCOUNT_ARTISAN) {
//       _navigationService.navigateToApplicationView(instantJobId: entityId);
//     } else {
//       _navigationService.navigateToNotificationJobDetailView(
//         instantJobId: entityId,
//         user: currentUser!,
//       );
//     }
//     break;
//   case 'post':
//     try {
//       Post post = posts.where((element) => element.id == entityId).first;

//       _navigationService.navigateToPostDetailView(post: post, postIndex: 0);
//     } catch (e) {
//       print('error: $e');
//     }
//     break;
//   case 'voice':
//   case 'video':
//     print('this is voice/video call');
//     List<Contact> contacts = await _contactService.getContacts();
//     List<Contact> list = contacts
//         .where((element) => element.id == message.data['callerId'])
//         .toList();
//     if (list.isEmpty) {
//       print('no contact found');
//       return;
//     }
//     Contact contact = list.first;
//     print('contact found: ${contact.toJson()}');
//     _bottomSheetService.showCustomSheet(
//       variant: BottomSheetType.ongoing_video_call,
//       isScrollControlled: true,
//       data: {
//         'contact': contact.toJson(),
//         'call_role': 'audience',
//       },
//     );

//     break;
//   default:
//     print("default notification");
//     return;
// }
// }

// Future<void> _receiveNotification(RemoteMessage message) async {
//   await _notificationService.getAccountNotifications(currentUser!.id!);
//   print('defafult notifications');
//   BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//     message.notification!.body.toString(),
//     htmlFormatBigText: true,
//     contentTitle: message.notification!.title.toString(),
//     htmlFormatContent: true,
//   );
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID,
//     HANDJOB_NOTIFICATION_MESSAGE_CHANNEL_ID,
//     channelDescription: "",
//     importance: Importance.max,
//     styleInformation: bigTextStyleInformation,
//     priority: Priority.max,
//     playSound: true,
//   );

//   NotificationDetails platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//   );

//   print(
//       'Message also contained a notification: ${message.notification?.toMap()}');
//   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   SheetResponse? _sheetResponse;
//   if (message.data["callType"] != null) {
//     List<Contact> contacts = await _contactService.getContacts();
//     // print('contacts: ${contacts.map((e) => e.toJson()).toList()}');
//     List<Contact> list = contacts
//         .where((element) => element.id == message.data['callerId'])
//         .toList();
//     print('caller id: ${message.data["callerId"]}');

//     if (list.isNotEmpty) {
//       if (message.data["callType"] == VOICE_CALL ||
//           message.data["callType"] == VIDEO_CALL) {
//         //show any type of notification ...
//         Contact contact = list.first;
//         print('contact found: ${contact.toJson()}');

//         var response = await _bottomSheetService.showCustomSheet(
//             variant: BottomSheetType.incoming_call,
//             isScrollControlled: true,
//             title: "Incoming Call",
//             data: {
//               'contact': contact,
//               'type': message.data["callType"],
//             });
//         if (response != null && response.confirmed) {
//           switch (response.data) {
//             case ACCEPT_CALL:
//               // _bottomSheetService.showCustomSheet(
//               //   variant: message.data["callType"] == VIDEO_CALL
//               //       ? BottomSheetType.ongoing_video_call
//               //       : BottomSheetType.ongoing_voice_call,
//               //   isScrollControlled: true,
//               //   data: {
//               //     'contact': contact,
//               //     'call_role': 'audience',
//               //   },
//               // );
//               _navigationService.navigateToOngoingVideoCallView(
//                   contact: contact, callRole: 'audience');
//               break;
//             case REJECT_CALL:
//               var formData = {
//                 "callType": 'cancel',
//                 "callId": contact.id,
//                 "callName": '${contact.firstName} ${contact.lastName}',
//                 "callerId": '${currentUser?.id}',
//                 "callerName":
//                     '${currentUser?.firstName} ${currentUser?.lastName}',
//                 "callRole": 'audience',
//                 "notificationType":
//                     message.data["callType"] == VIDEO_CALL ? 'video' : 'voice'
//               };
//               await _videoCallService.sendNotification(formData);

//               break;
//             default:
//               print("All good nothing to trigger: ${response.data}");
//           }
//         }
//       }
//     } else if (message.data["callType"] == "cancel") {
//       print('cancelled notifications');
//       // await flutterLocalNotificationsPlugin.cancelAll();
//     } else if (message.data['callType'] == 'end_call') {
//       _navigationService.navigateToContactView();
//       print('end call notifications');
//       // _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
//       try {
//         await _videoCallService.agoraEngine.leaveChannel();
//         await _videoCallService.agoraEngine.release();
//         await _videoCallService.agoraEngine.stopPreview();
//         //close bottom sheet_

//         print('close bottom sheet');
//         print('bottom sheet is open and about to be closed');
//         // _bottomSheetService.completeSheet(SheetResponse(
//         //   confirmed: true,
//         // )); //complete any sheet
//       } catch (e) {
//         print('error closing channel: $e');
//       }
//     } else {
//       await flutterLocalNotificationsPlugin.show(
//         message.notification.hashCode,
//         message.notification!.title,
//         message.notification!.body,
//         platformChannelSpecifics,
//         payload: message.data['title'],
//       );
//     }
//   }
// }
