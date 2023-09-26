import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/utils/contants.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/contact.model.dart';
import '../../models/user.model.dart';
import '../../services/authentication.service.dart';
import '../../services/video-call.service.dart';
import '../../utils/helpers.dart';

const _failedToStartVideoEngine = 'Failed to start video engine';
const _failedToJoinCall = 'Failed to join call';

class OngoingVideoCallViewModel extends ReactiveViewModel {
  final _videoCallService = locator<VideoCallService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  late RtcEngine agoraEngine; // Agora engine instance
  // RtcEngine? get agoraEngine => _agoraEngine;
  int uid = 0; // uid of the local user
  int? _remoteUid; // uid of the remote user
  int? get remoteUid => _remoteUid;
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool get isJoined => _isJoined;
  bool engineStarted = false;

  String callStatus = "Calling...";

  final bool _isHost = false;
  bool get isHost => _isHost;
  String _channelId = "";
  String get channelId => _channelId;

  Contact? _contact;
  Contact? get contact => _contact;
  User? get currentUser => _authenticationService.currentUser;
  String callRole = 'audience';

  late final Timer calltimer;
  int call_m = 0;
  int call_s = 0;
  int call_h = 0;
  bool is_calltimer = false;

  String callTimeDuration = "";
  String callTimer = "00:00";
  bool isReadyPreview = false;
  bool switchCameras = true;

  ChannelProfileType channelProfileType =
      ChannelProfileType.channelProfileCommunication;

  AudioPlayer player = AudioPlayer();

  Future<String?> getToken() async {
    if (callRole == 'anchor') {
      _channelId = generateMd5("${currentUser?.id}_${contact?.id}");
    } else {
      _channelId = generateMd5("${contact?.id}_${currentUser?.id}");
    }
    // _channelId = APP_CHANNEL_ID;

    var formData = {
      "channelName": channelId,
      "role": callRole == "anchor" ? "anchor" : "audience",
      "tokenType": "uid",
      "expiry": 3600 * 2,
      "uid": uid.toString()
    };
    print('[VIDEO CALL] Generating Token: $formData');
    var response = await _videoCallService.generateToken(formData);
    return response.rtcToken;
  }

  Future<void> initEngine() async {
    try {
      await player.setAsset('assets/ringtones/outgoing.mp3');

      //create an instance of the Agora engine
      agoraEngine = createAgoraRtcEngine();
      await agoraEngine.initialize(const RtcEngineContext(
        appId: appId,
      ));

      _videoCallService.setAgoraEngine(agoraEngine); // set the service instance
      // Register the event handler
      agoraEngine.registerEventHandler(
        RtcEngineEventHandler(
          onError: (err, msg) {
            log("[VIDEO CALL] [onError] err: $err, msg: $msg");
          },
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            log("[VIDEO CALL] ...onConnection: ${connection.toJson()}");
            _isJoined = true;
            notifyListeners();
          },
          onUserJoined:
              (RtcConnection connection, int remoteUid, int elapsed) async {
            log("[VIDEO CALL] Remote user uid:$remoteUid joined the channel");
            await player.pause();
            _remoteUid = remoteUid;
            if (callRole == "anchor") {
              callTime();
              is_calltimer = true;
            }
            notifyListeners();
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            log("[VIDEO CALL] Remote user uid:$remoteUid left the channel");
            _remoteUid = null;
            notifyListeners();
          },
          onRtcStats: (connection, stats) {
            log("[VIDEO CALL] Connection $connection, stats: $stats");

            notifyListeners();
          },
          //       onLeaveChannel: (connection, stats) {
          //         print("...user left the call stats: ${stats.toJson()}");
          // _isJoined = false;
          //       },
        ),
      );

      await agoraEngine.enableVideo();
      await agoraEngine.enableAudio();

      await agoraEngine.setVideoEncoderConfiguration(
        const VideoEncoderConfiguration(
          dimensions: VideoDimensions(width: 640, height: 360),
          frameRate: 15,
          bitrate: 0,
        ),
      );

      await agoraEngine.setClientRole(
          role: ClientRoleType.clientRoleBroadcaster);
      await agoraEngine.setAudioProfile(
        profile: AudioProfileType.audioProfileDefault,
        scenario: AudioScenarioType.audioScenarioGameStreaming,
      );

      await agoraEngine.startPreview();
      isReadyPreview = true;
      await joinChannel();
      print('[VIDEO CALL] callRole: $callRole');
      if (callRole == 'anchor') {
        await sendNotification("video");
        await player.setLoopMode(LoopMode.all);
        await player.play();
      }
      notifyListeners();
    } catch (e) {
      debugPrint('agora exception to manager $e');
    }
  }

  Future<void> sendNotification(String callType) async {
    var formData = {
      "callType": callType,
      "callId": contact?.id,
      "callName": '${contact?.firstName} ${contact?.lastName}',
      "callerId": '${currentUser?.id}',
      "callerName": '${currentUser?.firstName} ${currentUser?.lastName}',
      "callRole": callRole,
      "notificationType": 'video'
    };
    try {
      await _videoCallService.sendNotification(formData);
      print('[VIDEO CALL] response: notification send');
    } catch (e) {
      print('error on notification send: $e');
    }
  }

  Future<void> joinChannel() async {
    // retrieve or request microphone permission
    await [Permission.microphone, Permission.camera, Permission.audio]
        .request();
    setBusyForObject(JOIN_CHANNEL, true);
    String? token = await getToken();
    if (token == null) {
      log("a valid token was not generated");
      return;
    }
    await agoraEngine.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options: ChannelMediaOptions(
        channelProfile: channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
    if (callRole == "audience") {
      callTime();
      is_calltimer = true;
    }
    setBusyForObject(JOIN_CHANNEL, false);
  }

  void leaveChannel() async {
    setBusyForObject(LEAVE_CHANNEL, true);
    await player.pause();
    _isJoined = false;
    switchCameras = true;
    sendNotification("end_call");
    _dispose();
    setBusyForObject(LEAVE_CHANNEL, false);
    _navigationService.back();
  }

  Future<void> _dispose() async {
    await player.pause();
    if (isReadyPreview) {
      try {
        await agoraEngine.leaveChannel();
        await agoraEngine.release();
      } catch (e) {
        print('error closing channel: $e');
      }
    }
    await player.stop();
  }

  @override
  void dispose() {
    _dispose();
  }

  callTime() async {
    calltimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      call_s = call_s + 1;
      if (call_s >= 60) {
        call_s = 0;
        call_m = call_m + 1;
      }
      if (call_m >= 60) {
        call_m = 0;
        call_h = call_h + 1;
      }
      var h = call_h < 10 ? "0$call_h" : "$call_h";
      var m = call_m < 10 ? "0$call_m" : "$call_m";
      var s = call_s < 10 ? "0$call_s" : "$call_s";

      if (call_h == 0) {
        callTimer = "$m:$s";
        callTimeDuration = "$call_m m and $call_s s";
      } else {
        callTimer = "$h:$m:$s";
        callTimeDuration = "$call_h h $call_m m and $call_s s";
      }
    });
  }

  Future<void> switchCamera() async {
    await agoraEngine.switchCamera();
    switchCameras = !switchCameras;
  }

  updateContact(Contact contact) {
    _contact = contact;
    notifyListeners();
  }

  updateCallRole(String role) {
    callRole = role;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_videoCallService];
}
