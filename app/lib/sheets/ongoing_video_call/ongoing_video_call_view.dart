import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/sheets/ongoing_video_call/ongoing_video_call_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../models/contact.model.dart';
import '../../utils/contants.dart';

class OngoingVideoCallView extends StatelessWidget {
  const OngoingVideoCallView({
    super.key,
    required this.contact,
    required this.callRole,
  });

  final Contact contact;
  final String callRole;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OngoingVideoCallViewModel>.reactive(
      viewModelBuilder: () => OngoingVideoCallViewModel(),
      onViewModelReady: (model) async {
        model.streamSubscriptionRemoteMessage =
            FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          print('remote message inside the call app ${message.data}');
          if (message.data['callType'] == "end_call") {
            print('end caller call');
            model.leaveChannel();
            // if (message.data['callerId'] == model.currentUser?.id) {
            // print('Call ended');
            // }
          }
        });
        model.updateContact(contact);
        model.updateCallRole(callRole);
        model.initEngine();
      },
      onDispose: (model) async {
        await model.streamSubscriptionRemoteMessage?.cancel();
        model.dispose();
      },
      builder: (context, model, _) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.zero,
            child: model.isReadyPreview
                ? Stack(
                    children: [
                      const _RemoteVideoView(),
                      const _LocalVideoView(),
                      Column(
                        children: [
                          Expanded(child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () => model.leaveChannel(),
                                // onPressed: model.isJoined
                                //     ? () => model.leaveChannel(completer)
                                //     : model.joinChannel,
                                child:
                                    model.busy(JOIN_CHANNEL) && !model.isJoined
                                        ? const CircularProgressIndicator()
                                        : const Icon(
                                            Icons.call_end,
                                            size: AppSize.s24,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                backgroundColor: model.isJoined
                                    ? ColorManager.kRed
                                    : ColorManager.kTransparent,
                              ),
                              const SizedBox(width: 24),
                              GestureDetector(
                                onTap: model.switchCamera,
                                child: Container(
                                  padding: const EdgeInsets.all(AppPadding.p16),
                                  decoration: BoxDecoration(
                                    // color: ColorManager.kTransparent,
                                    color: model.switchCameras
                                        ? ColorManager.kBackgroundolor
                                        : ColorManager.kBackgroundolor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    model.switchCameras
                                        ? Icons.camera_front
                                        : Icons.camera_rear,
                                    size: AppSize.s32,
                                    color: ColorManager.kDarkCharcoal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.s80)
                        ],
                      ),
                    ],
                  )
                : Container(),
          ),
        );
      },
    );
  }
}

class _RemoteVideoView extends ViewModelWidget<OngoingVideoCallViewModel> {
  const _RemoteVideoView();

  @override
  Widget build(BuildContext context, OngoingVideoCallViewModel model) {
    final remoteUid = model.remoteUid;
    final isJoined = model.isJoined;

    if (isJoined && remoteUid != null) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: model.agoraEngine,
              canvas: VideoCanvas(uid: remoteUid),
              connection: RtcConnection(channelId: model.channelId),
            ),
          ),
        ),
      );
    } else {
      String msg = '';
      if (isJoined) msg = 'Waiting for a remote user to join';
      return Center(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      );
    }
  }
}

class _LocalVideoView extends ViewModelWidget<OngoingVideoCallViewModel> {
  const _LocalVideoView();

  @override
  Widget build(BuildContext context, OngoingVideoCallViewModel model) {
    return Positioned(
      top: AppSize.s60,
      right: AppSize.s16,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ColorManager.kGrey4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 170,
          width: 125,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.s4),
            ),
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: model.agoraEngine,
                canvas: VideoCanvas(uid: model.uid),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// class OngoingVideoCallView extends StatelessWidget {
//   const OngoingVideoCallView({
//     super.key,
//     this.request,
//     this.completer,
//   });

//   final SheetRequest? request;
//   final Function(SheetResponse)? completer;

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<OngoingVideoCallViewModel>.reactive(
//       viewModelBuilder: () => OngoingVideoCallViewModel(),
//       onViewModelReady: (model) async {
//         if (request?.data != null) {
//           Contact contact = request?.data['contact'] as Contact;
//           String callRole = request?.data['call_role'] as String;

//           model.updateContact(contact);
//           model.updateCallRole(callRole);
//           model.initEngine();
//         }
//       },
//       onDispose: (model) {
//         model.dispose();
//       },
//       builder: (context, model, _) {
//         return BottomSheetContainer(
//           showClose: false,
//           padding: EdgeInsets.zero,
//           onClose: () => completer!(SheetResponse(confirmed: false)),
//           child: model.isReadyPreview
//               ? Stack(
//                   children: [
//                     const _RemoteVideoView(),
//                     const _LocalVideoView(),
//                     Column(
//                       children: [
//                         Expanded(child: Container()),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             FloatingActionButton(
//                               onPressed: () => model.leaveChannel(completer),
//                               // onPressed: model.isJoined
//                               //     ? () => model.leaveChannel(completer)
//                               //     : model.joinChannel,
//                               child: model.busy(JOIN_CHANNEL) && !model.isJoined
//                                   ? const CircularProgressIndicator()
//                                   : const Icon(
//                                       Icons.call_end,
//                                       size: AppSize.s24,
//                                       color: ColorManager.kWhiteColor,
//                                     ),
//                               backgroundColor: model.isJoined
//                                   ? ColorManager.kRed
//                                   : ColorManager.kTransparent,
//                             ),
//                             const SizedBox(width: 24),
//                             GestureDetector(
//                               onTap: model.switchCamera,
//                               child: Container(
//                                 padding: const EdgeInsets.all(AppPadding.p16),
//                                 decoration: BoxDecoration(
//                                   // color: ColorManager.kTransparent,
//                                   color: model.switchCameras
//                                       ? ColorManager.kBackgroundolor
//                                       : ColorManager.kBackgroundolor,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   model.switchCameras
//                                       ? Icons.camera_front
//                                       : Icons.camera_rear,
//                                   size: AppSize.s32,
//                                   color: ColorManager.kDarkCharcoal,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: AppSize.s80)
//                       ],
//                     ),
//                   ],
//                 )
//               : Container(),
//         );
//       },
//     );
//   }
// }

// class _RemoteVideoView extends ViewModelWidget<OngoingVideoCallViewModel> {
//   const _RemoteVideoView();

//   @override
//   Widget build(BuildContext context, OngoingVideoCallViewModel model) {
//     final remoteUid = model.remoteUid;
//     final isJoined = model.isJoined;

//     if (isJoined && remoteUid != null) {
//       return Positioned(
//         top: 0,
//         left: 0,
//         right: 0,
//         bottom: 0,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: AgoraVideoView(
//             controller: VideoViewController.remote(
//               rtcEngine: model.agoraEngine,
//               canvas: VideoCanvas(uid: remoteUid),
//               connection: RtcConnection(channelId: model.channelId),
//             ),
//           ),
//         ),
//       );
//     } else {
//       String msg = '';
//       if (isJoined) msg = 'Waiting for a remote user to join';
//       return Center(
//         child: Text(
//           msg,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//       );
//     }
//   }
// }

// class _LocalVideoView extends ViewModelWidget<OngoingVideoCallViewModel> {
//   const _LocalVideoView();

//   @override
//   Widget build(BuildContext context, OngoingVideoCallViewModel model) {
//     return Positioned(
//       top: AppSize.s60,
//       right: AppSize.s16,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: ColorManager.kGrey4,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: SizedBox(
//           height: 170,
//           width: 125,
//           child: ClipRRect(
//             borderRadius: const BorderRadius.all(
//               Radius.circular(AppSize.s4),
//             ),
//             child: AgoraVideoView(
//               controller: VideoViewController(
//                 rtcEngine: model.agoraEngine,
//                 canvas: VideoCanvas(uid: model.uid),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
