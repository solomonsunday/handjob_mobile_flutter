import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class IncomingCallViewModel extends ReactiveViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  @override
  List<ListenableServiceMixin> get listenableServices => [];

  bool _micOn = true;
  bool get micOn => _micOn;

  void toggleMic() {
    _micOn = !_micOn;
    notifyListeners();
  }

  // Future<void> acceptCall() async {
  //   hideIncomingCallDialog();
  //   ZegoResponseInvitationResult result = await ZEGOSDKManager.instance.zimService.acceptInvitation(
  //     invitationID: ZegoCallStateManager.instance.callData!.callID,
  //   );
  //   if (result.error == null || result.error?.code == '0') {
  //     pushToCallingPage();
  //   }
  // }

  // Future<void> rejectCall() async {
  //   hideIncomingCallDialog();
  //   ZEGOSDKManager.instance.zimService.rejectInvitation(
  //     invitationID: ZegoCallStateManager.instance.callData!.callID,
  //   );
  // }

  hideIncomingCallDialog() async {}

  // void pushToCallingPage() {
  //   print('See whose calling');
  //   print('Detail: ${ZegoCallStateManager.instance.callData}');
  //   if (ZegoCallStateManager.instance.callData != null) {
  //     ZegoUserInfo otherUser;
  //     if (ZegoCallStateManager.instance.callData!.inviter.userID !=
  //         ZEGOSDKManager.instance.localUser.userID) {
  //       otherUser = ZegoCallStateManager.instance.callData!.inviter;
  //     } else {
  //       otherUser = ZegoCallStateManager.instance.callData!.invitee;
  //     }
  //     if (ZegoCallStateManager.instance.callData?.callType ==
  //         ZegoCallType.video) {
  //       _bottomSheetService.showCustomSheet(
  //         variant: BottomSheetType.ongoing_video_call,
  //         data: ZegoCallStateManager.instance.callData,
  //         ignoreSafeArea: true,
  //         isScrollControlled: true,
  //       );
  //     } else {
  //       _bottomSheetService.showCustomSheet(
  //         variant: BottomSheetType.ongoing_voice_call,
  //         data: ZegoCallStateManager.instance.callData,
  //         ignoreSafeArea: true,
  //         isScrollControlled: true,
  //       );
  //     }
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     fullscreenDialog: true,
  //     //     builder: (context) =>
  //     //         CallingPage(callData: ZegoCallStateManager.instance.callData!, otherUserInfo: otherUser),
  //     //   ),
  //     // );
  //   }
  // }
}
