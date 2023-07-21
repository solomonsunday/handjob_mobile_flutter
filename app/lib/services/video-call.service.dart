import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../models/user.model.dart';
import '../utils/contants.dart';

// const String VIDEO_CALL_SERVER_URL =
//     "https://video-call-server.herokuapp.com/video-call";

/**
 * 
{
    "userId": "ae4c8842-f1c3-496c-97ac-9325fe0cec7d",
    "from": "213c3af4-5975-419c-8259-c42c68a01423",
    "name": "David",
    "signal": {
        "buffer": ["323"]
    }
}
 */
// const String TEST_AUTHORIZATION =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImRhdmlkIiwic3ViIjoiMjEzYzNhZjQtNTk3NS00MTljLTgyNTktYzQyYzY4YTAxNDIzIiwiZW1haWwiOiJkYXZpZEBnbWFpbC5jb20iLCJpYXQiOjE2Nzc1NDA3NzIsImV4cCI6MTY3NzYyNzE3Mn0.OMZ-7N90n3z5026EXGhslYxVM4UQ8GzyqOaA-EoYvfs";

class VideoCallService with ListenableServiceMixin {
  ZegoUIKitPrebuiltCallController? callController;
  final _navigationService = locator<NavigationService>();

  VideoCallService() {
    listenToReactiveValues([]);
  }

//using the prebuilt ui kit
  Future<void> onZegoUserConnect(User? currentUser) async {
    callController ??= ZegoUIKitPrebuiltCallController();

    String name = '${currentUser?.firstName} ${currentUser?.lastName}';
    try {
      String? callId;
      await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: ZEGO_APP_ID,
        appSign: ZEGO_APP_SIGNATURE,
        userID: currentUser?.id ?? "",
        userName: name,
        controller: callController,
        events: ZegoUIKitPrebuiltCallInvitationEvents(
          onIncomingCallDeclineButtonPressed: () {
            ///  Add your custom logic here.
          },
          onIncomingCallAcceptButtonPressed: () {
            ///  Add your custom logic here.
            print('call id: $callId');
            _navigationService.navigateToCallView(callID: callId ?? "", currentUser: currentUser!,);
          },
          onIncomingCallReceived: (
            String callID,
            ZegoCallUser caller,
            ZegoCallType callType,
            List<ZegoCallUser> callees,
            String customData,
          ) {
            ///  Add your custom logic here.
            callId = callID;
          },
          onIncomingCallCanceled: (String callID, ZegoCallUser caller) {
            ///  Add your custom logic here.
          },
          onIncomingCallTimeout: (String callID, ZegoCallUser caller) {
            ///  Add your custom logic here.
          },
          onOutgoingCallCancelButtonPressed: () {
            ///  Add your custom logic here.
          },
          onOutgoingCallAccepted: (String callID, ZegoCallUser callee) {
            ///  Add your custom logic here.
          },
          onOutgoingCallRejectedCauseBusy:
              (String callID, ZegoCallUser callee) {
            ///  Add your custom logic here.
          },
          onOutgoingCallDeclined: (String callID, ZegoCallUser callee) {
            ///  Add your custom logic here.
          },
          // onOutgoingCallTimeout: (String callID, List<ZegoCallUser> callees) {
          //   ///  Add your custom logic here.
          // },
        ),
        plugins: [ZegoUIKitSignalingPlugin()],
        ringtoneConfig: const ZegoRingtoneConfig(
          incomingCallPath: "assets/ringtones/incoming.mp3",
          outgoingCallPath: "assets/ringtones/outgoing.mp3",
        )
      );
    } catch (e) {
      print("Eror: " + e.toString());
    }
  }

  void onZegoUserDisconnect() {
    callController = null;
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
