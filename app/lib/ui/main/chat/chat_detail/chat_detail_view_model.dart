import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/chat-payload.model.dart';
import 'package:handjob_mobile/services/chat.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app.locator.dart';
import '../../../../enums/bottom_sheet_type.dart';
import '../../../../models/contact.model.dart';
import '../../../../models/conversation.model.dart';
import '../../../../models/user.model.dart';
import '../../../../services/authentication.service.dart';

class ChatDetailViewModel extends ReactiveViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _chatService = locator<ChatService>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  User? get user => _authenticationService.currentUser;

  // List<Conversation> _chatList = [];
  List<Conversation> get chatList => _chatService.chats;

  bool _isSendText = false;
  bool get isSendText => _isSendText;
  String _chatMessage = "";
  String get chatMessage => _chatMessage;

  TextEditingController chatMessageController = TextEditingController();

  handleChange(String value) {
    _chatMessage = value;
    notifyListeners();
  }

  void navigateBack() {
    print('back');
    _navigationService.back();
  }

  handleSearch(String p1) {}

  void getChatsWithPartner(Contact contact) async {
    try {
      await _chatService.getChatsWithPartner(contact.id!);
      await _chatService.markAsRead(contact.id!);
    } on DioError catch (e) {
    } finally {
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_chatService];

  void createChat(Contact contact) async {
    Map<String, dynamic> formData = {
      "audioUrl": "",
      "createdAt": DateTime.now().toIso8601String(),
      "imageUrl": "",
      "message": chatMessageController.text,
      "recieverId": contact.id,
      "senderId": user?.id,
      "title": "${contact.firstName} ${contact.lastName}",
      "videoUrl": ""
    };
    try {
      await _chatService.createChat(formData);
      // await _chatService.getChatsWithPartner(contact.id!);
    } on DioError catch (e) {
      print('error: ${e}');
    } finally {
      chatMessageController.clear();

      notifyListeners();
    }
  }

  handleAudioCall(Contact contact) {
    _makePhoneCall(contact.phoneNumber!);
  }

  _makePhoneCall(String phoneNumber) async {
    await launchUrl(
      Uri(
        scheme: 'tel',
        path: phoneNumber,
      ),
    );
  }

  //handle video call
  handleVideoCall(Contact p1) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.outgoing_call,
      title: "Outgoing Video Call",
      data: {"type": "video"},
      isScrollControlled: true,
    );
  }
}
