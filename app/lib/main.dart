import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/utils/setup_notification.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.dialogs.dart';
import 'utils/setup_bottom_sheet_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../../utils/contants.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('messsage receive background: ${message.data}');
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  setupNotification(messaging);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  setupBottomSheetUi();
  setupDialogUi();
  //subscribe for push notification...
  runApp(const MyApp());
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupSubscription();
  setupNotification(messaging);
}

void setupSubscription() async {
  await messaging.subscribeToTopic(JOBS);
  await messaging.subscribeToTopic(CONNECTION_REQUEST);
  await messaging.subscribeToTopic(POST);
  await messaging.subscribeToTopic(APPLICATION);
  await messaging.subscribeToTopic(REVIEW);
  await messaging.subscribeToTopic(CHAT);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.nonReactive(
      viewModelBuilder: () => AppViewModel(),
      builder: (context, model, _) {
        return MaterialApp(
          title: 'Handyworker Mobile',
          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }
}

class AppViewModel extends BaseViewModel {}
