import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/chat-payload.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/chat.model.dart';
import '../models/conversation.model.dart';

const String CHAT_SOCKET_SERVER_URL =
    'https://api-jobplicant.herokuapp.com/notigateway';

class ChatService with ReactiveServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  late IO.Socket socket;

  ChatService() {
    listenToReactiveValues([
      chats,
      // chatConversation,
      conversationList,
    ]);
  }

  initSocket() {
    socket = IO.io(CHAT_SOCKET_SERVER_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      // print('Connection established');
      socket.on("chat_msg_to_client", (data) {
        Conversation content = Conversation.fromJson(data);
        _chats = [...chats, content];
        // notifyListeners();
      });
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  IO.Socket get chatSocket => socket;

  List<Conversation> _chats = [];
  List<Conversation> get chats => _chats;
  Chat? _chatConversation;
  Chat? get chatConversation => _chatConversation;
  List<Conversation> _conversationList = [];
  List<Conversation> get conversationList => _conversationList;

  void clearChatWithPartner() {
    _chats = [];
  }

  Future<bool> createChat(Map<String, dynamic> formData) async {
    // socket.emit('chat_msg_to_client', formData);
    var response = await dioClient.post('/chat', data: formData);
    // print('response data : ${response.data}');

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
    _chats = [];

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
