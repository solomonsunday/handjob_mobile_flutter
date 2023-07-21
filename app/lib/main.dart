
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'app/app.dialogs.dart';
import 'utils/setup_bottom_sheet_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
  setupLocator();
  setupBottomSheetUi();
  setupDialogUi();
  //subscribe for push notification...
  setupSubscription();
  setupNotification(messaging);
  //  /// 1.1.1 define a navigator key
  // final navigatorKey = GlobalKey<NavigatorState>();

  // /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(StackedService.navigatorKey!);
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
        // model.initializeView();
      },
      onDispose: (model) {
        // model.dispose();
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
  // List<StreamSubscription> subscriptions = [];
  
  initializeView() async {
    // await _chatService.initSocket();
    // subscriptions.addAll([
    //   ZEGOSDKManager.instance.zimService.incomingCallInvitationReceivedStreamCtrl.stream.listen(
    //     onIncomingCallInvitationReceived,
    //   ),
    //   ZEGOSDKManager.instance.zimService.incomingCallInvitationCanceledStreamCtrl.stream.listen(
    //     onIncomingCallInvitationCanceled,
    //   ),
    //   ZEGOSDKManager.instance.zimService.incomingCallInvitationTimeoutStreamCtrl.stream.listen(
    //     onIncomingCallInvitationTimeout,
    //   )
    // ]);
  }

  //  void onIncomingCallInvitationReceived(IncomingCallInvitationReveivedEvent event) {
  //   print('onIncomingCallInvitationReceived');
  //   print(event);
    // dialogIsShowing = true;
    // showTopModalSheet(
    //   context,
    //   GestureDetector(
    //     onTap: onIncomingCallDialogClicked,
    //     child: ZegoCallInvitationDialog(
    //       invitationData: ZegoCallStateManager.instance.callData!,
    //       onAcceptCallback: acceptCall,
    //       onRejectCallback: rejectCall,
    //     ),
    //   ),
    //   barrierDismissible: false,
    // );
  // }

  void hideIncomingCallDialog() {
    print('hideIncomingCallDialog');
    // if (dialogIsShowing) {
    //   dialogIsShowing = false;
    //   Navigator.of(context).pop();
    // }
  }

  // void onIncomingCallInvitationCanceled(IncomingCallInvitationCanceledEvent event) {
  //   hideIncomingCallDialog();
  // }

  //   void onIncomingCallInvitationTimeout(IncomingCallInvitationTimeoutEvent event) {
  //   hideIncomingCallDialog();
  // }

void pushToCallWaitingPage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     fullscreenDialog: true,
    //     builder: (context) => CallWaitingPage(callData: ZegoCallStateManager.instance.callData!),
    //   ),
    // );
  }

  void pushToCallingPage() {
    // if (ZegoCallStateManager.instance.callData != null) {
    //   ZegoUserInfo otherUser;
    //   if (ZegoCallStateManager.instance.callData!.inviter.userID != ZEGOSDKManager.instance.localUser.userID) {
    //     otherUser = ZegoCallStateManager.instance.callData!.inviter;
    //   } else {
    //     otherUser = ZegoCallStateManager.instance.callData!.invitee;
    //   }
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       fullscreenDialog: true,
    //       builder: (context) =>
    //           CallingPage(callData: ZegoCallStateManager.instance.callData!, otherUserInfo: otherUser),
    //     ),
    //   );
    // }
  }

  Future<T?> showTopModalSheet<T>(BuildContext context, Widget widget, {bool barrierDismissible = true}) {
    return showGeneralDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      transitionDuration: const Duration(milliseconds: 250),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) => SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 16),
          widget,
        ],
      )),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
              .drive(Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
          child: child,
        );
      },
    );
  }


  @override
  void dispose() {
    // chatSocket.disconnect();
    // chatSocket.dispose();
    super.dispose();
  }
}
