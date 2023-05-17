import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/socket-user.model.dart';
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

class VideoCallService with ReactiveServiceMixin {
  late IO.Socket socket;

  SocketUser? _socketUser;
  SocketUser? get socketUser => _socketUser;

  VideoCallService() {
    listenToReactiveValues([socketUser]);
  }

  IO.Socket get videoSocket => socket;

  initSocket() async {
    String? authorization;
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(AUTH_TOKEN_KEY) != null) {
      authorization = sharedPreferences.getString(AUTH_TOKEN_KEY);
    }
    print('authorization: $authorization');

    // socket = IO.io(
    //   VIDEO_CALL_SERVER_URL,
    //   OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
    //       .setTransports(['websocket']).setExtraHeaders(
    //           {'authorization': authorization}) // optional
    //       .build(),
    // );
    // socket.connect();
    // socket.onConnect((_) {
    //   print('Connection established');
    //   socket.on("me", (data) {
    //     print('me: $data');
    //     _socketUser = SocketUser.fromJson(data);
    //     notifyListeners();
    //   });
    //   socket.on('checkUserConnect', (data) {
    //     print('checkUserConnect: $data');
    //   });
    //   socket.on('error', (data) {
    //     print('error now: $data');
    //   });
    // });
    // socket.onDisconnect((_) => print('Connection Disconnection'));
    // socket.onConnectError((err) => print('onConnectError $err'));
    // socket.onError((err) => print('onError $err'));
  }

  void callUser(String? id) {
    videoSocket.emitWithAck(
        'checkUserConnect',
        SocketUser.fromJson({
          "userId": id,
        }), ack: (data) {
      print('checkUserConnect: $data');
    });
  }
}
