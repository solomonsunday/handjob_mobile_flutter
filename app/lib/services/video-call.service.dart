import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/rtc.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../client/dio_client.dart';

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
  Dio dioClient = locator<DioClient>().dio;
  final _navigationService = locator<NavigationService>();

  VideoCallService() {
    listenToReactiveValues([]);
  }

  Future<RtcToken> generateToken(Map formData) async {
    var response = await dioClient.post(
      '/generate/agora/token',
      data: formData,
    );

    return RtcToken.fromJson(response.data);
  }

  Future<void> sendNotification(Map formData) async {
    var response = await dioClient.post(
      '/send-notification',
      data: formData,
    );
  }
}
