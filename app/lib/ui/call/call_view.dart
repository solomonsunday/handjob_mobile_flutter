import 'package:flutter/material.dart';
import 'package:handjob_mobile/utils/contants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../models/user.model.dart';

class CallView extends StatelessWidget {
  const CallView({super.key, required this.callID, required this.currentUser,});

  final String callID;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(appID: ZEGO_APP_ID, appSign: ZEGO_APP_SIGNATURE, callID: callID, userID: currentUser.id!, userName: '${currentUser.firstName} ${currentUser.lastName}', config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),);
  }
}