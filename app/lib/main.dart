import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'services/authentication.service.dart';
import 'services/chat.service.dart';
import 'utils/setup_bottom_sheet_ui.dart';
import 'utils/setup_dialog_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'utils/setup_notification.dart';
import '../../utils/contants.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  setupNotification(messaging);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupNotification(messaging);
  setupLocator();
  setupBottomSheetUi();
  setupDialogUi();
  //subscribe for push notification...
  await messaging.subscribeToTopic(JOBS);
  await messaging.subscribeToTopic(CONNECTION_REQUEST);
  await messaging.subscribeToTopic(POST);
  await messaging.subscribeToTopic(APPLICATION);
  await messaging.subscribeToTopic(REVIEW);
  await messaging.subscribeToTopic(CHAT);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.nonReactive(
      viewModelBuilder: () => AppViewModel(),
      onModelReady: (model) {
        model.initializeView();
      },
      onDispose: (model) {
        model.dispose();
      },
      builder: (context, model, _) {
        return MaterialApp(
          title: 'HandJobs Mobile',
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

class AppViewModel extends BaseViewModel {
  final _chatService = locator<ChatService>();

  IO.Socket get chatSocket => _chatService.chatSocket;

  initializeView() async {
    await _chatService.initSocket();
  }

  @override
  void dispose() {
    chatSocket.disconnect();
    chatSocket.dispose();
    super.dispose();
  }
}
