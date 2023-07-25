import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.dialogs.dart';
import 'managers/call_manager.dart';
import 'services/authentication.service.dart';
import 'utils/platform_utils.dart';
import 'utils/setup_bottom_sheet_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/setup_notification.dart';
import '../../utils/contants.dart';

import 'package:connectycube_sdk/connectycube_sdk.dart';

String appId = "7221";
String authKey = "xJhUtyzKwfVrNzu";
String authSecret = "23EubUj5jJdXKFb";
P2PSession? callSession;

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
  //  /// 1.1.1 define a navigator key
  // final navigatorKey = GlobalKey<NavigatorState>();

  CubeSettings.instance.isDebugEnabled =
      true; // to enable ConnectyCube SDK logs;
  // /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  // ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(StackedService.navigatorKey!);
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.nonReactive(
      viewModelBuilder: () => AppViewModel(),
      onViewModelReady: (model) {
        // initializeCallSession();

        initForegroundService();

        checkSystemAlertWindowPermission(context);

        requestNotificationsPermission();
        // PushNotificationsManager.instance.init();
        init(appId, authKey, authSecret, onSessionRestore: restoreSession);
      },
      onDispose: (model) {
        // model.dispose();
      },
      builder: (context, model, _) {
        CallManager.instance.init(context);
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

  Future<CubeSession> restoreSession() {
  // CubeUser savedUser; //some CubeUser, which was saved before
  if(currentUser != null) {
    var name = '${currentUser?.firstName} ${currentUser?.lastName}';
    return createSession(CubeUser(
        // isGuest: true,
        // id: 123,
        login: currentUser?.id,
        fullName: name,
        email: currentUser?.email,
        avatar: currentUser?.imageUrl,
        password: "DEFAULT_PASS",
        
      ));
  }
  return createSession();
}
}

class AppViewModel extends BaseViewModel {
  // final _chatService = locator<ChatService>();

  @override
  void dispose() {
    // chatSocket.disconnect();
    // chatSocket.dispose();
    super.dispose();
  }
}
