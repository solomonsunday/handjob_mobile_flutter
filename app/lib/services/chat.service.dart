import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/chat.model.dart';
import '../models/conversation.model.dart';

class ChatService with ReactiveServiceMixin {
  IO.Socket socket = IO.io('https://api-jobplicant.herokuapp.com/notigateway');
  Dio dioClient = locator<DioClient>().dio;

  ChatService() {
    socket.on('connect', (data) => print('connected'));
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    listenToReactiveValues([
      chats,
      // chatConversation,
      conversationList,
    ]);
  }

  IO.Socket get chatSocket => socket;

  List<Conversation> _chats = [];
  List<Conversation> get chats => _chats;
  Chat? _chatConversation;
  Chat? get chatConversation => _chatConversation;
  List<Conversation> _conversationList = [];
  List<Conversation> get conversationList => _conversationList;

  Future<bool> createChat(Map<String, dynamic> formData) async {
    var response = await dioClient.post('/chat', data: formData);
    print('response data : ${response.data}');

    return true;
  }

  Future<List<Conversation>> getConversationList() async {
    var response = await dioClient.get("/chat/conversation-list");
    print('chats response: ${response.data}');

    _conversationList = (response.data["data"] as List<dynamic>)
        .map((e) => Conversation.fromJson(e))
        .toList();
    notifyListeners();
    return _conversationList;
    ;
  }

  Future<Chat> getChatsWithPartner(String partnerId) async {
    var response =
        await dioClient.get("/chat/conversation-messages/$partnerId");
    print('response data: ${response.data}');
    Chat chat = Chat.fromJson(response.data['data']);
    _chatConversation = chat;
    _chats = _chatConversation?.conversation ?? [];
    print('chatConversationRes: $_chats');
    notifyListeners();
    return chat;
  }

  markAsRead(String partnerId) async {
    var response = await dioClient.put("/chat/conversation/read/$partnerId");
    print('response mark as read: ${response.data}');
    return true;
  }

  Future<bool> deleteChat(String conversationId) async {
    var response = await dioClient.delete("/chat/$conversationId");
    print('response delete chat: ${response.data}');
    return true;
  }
}
