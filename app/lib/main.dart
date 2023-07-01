import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.dialogs.dart';
import 'services/chat.service.dart';
import 'utils/setup_bottom_sheet_ui.dart';
import 'utils/setup_dialog_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'utils/setup_notification.dart';
import '../../utils/contants.dart';

const APP_ID = '5feb1c0eda2d48b0ada9566bd39adaea';
const TOKEN = 'f0449690a0c940c581cbaaad2570ee3d';

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
  setupLocator();
  setupBottomSheetUi();
  setupDialogUi();
  //subscribe for push notification...
  setupSubscription();
  setupNotification(messaging);
  runApp(const MyApp());
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

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.nonReactive(
      viewModelBuilder: () => AppViewModel(),
      onViewModelReady: (model) {
        model.initializeView();
      },
      onDispose: (model) {
        model.dispose();
      },
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

class AppViewModel extends BaseViewModel {
  // final _chatService = locator<ChatService>();

  // IO.Socket get chatSocket => _chatService.chatSocket;

  initializeView() async {
    // await _chatService.initSocket();
  }

  @override
  void dispose() {
    // chatSocket.disconnect();
    // chatSocket.dispose();
    super.dispose();
  }
}
