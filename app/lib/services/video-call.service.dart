import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
  final _navigationService = locator<NavigationService>();

  VideoCallService() {
    listenToReactiveValues([]);
  }


}
