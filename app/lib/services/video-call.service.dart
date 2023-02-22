import 'package:stacked/stacked.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/socket-user.model.dart';

const String VIDEO_CALL_SERVER_URL =
    "https://video-call-server.herokuapp.com/video-call";

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

class VideoCallService with ReactiveServiceMixin {
  late IO.Socket socket;
  SocketUser? _socketUser;
  SocketUser? get socketUser => _socketUser;

  VideoCallService() {
    listenToReactiveValues([socketUser]);
  }

  initSocket() {
    socket = IO.io(VIDEO_CALL_SERVER_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      // print('Connection established');
      socket.on("me", (data) {
        print('me: $data');
        _socketUser = SocketUser.fromJson(data);
        notifyListeners();
      });
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }
}
