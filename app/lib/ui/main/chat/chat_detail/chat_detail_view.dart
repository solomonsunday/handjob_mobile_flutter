import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/contact.model.dart';
import '../../../../models/conversation.model.dart';
import 'chat_detail_view_model.dart';

const String ARCHIVE = 'ARCHIVE';
const String DELETE = 'DELETE';
const String MUTE = 'MUTE';
const String REPORT = 'REPORT';
const String BLOCK = 'BLOCK';

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatDetailViewModel>.reactive(
        viewModelBuilder: () => ChatDetailViewModel(),
        onViewModelReady: (model) {
          model.getChatsWithPartner(contact);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          model.navigateBack();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: contact.imageUrl == null
                            ? Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/logo.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                imageUrl: contact.imageUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${contact.firstName} ${contact.lastName}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Online",
                              style: getRegularStyle(
                                  color: ColorManager.kSecondaryColor,
                                  fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.settings,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () => model.handleVideoCall(contact),
                  child: const Icon(
                    Icons.videocam,
                    size: AppSize.s24,
                    color: ColorManager.kDarkColor,
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                GestureDetector(
                  onTap: () => model.handleAudioCall(contact),
                  child: const Icon(
                    Icons.call,
                    size: AppSize.s24,
                    color: ColorManager.kDarkColor,
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                PopupMenuButton(
                  onSelected: (String item) {},
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: ARCHIVE,
                      child: Row(children: [
                        Icon(
                          Icons.archive_outlined,
                          color: ColorManager.kDarkCharcoal,
                        ),
                        SizedBox(width: AppSize.s8),
                        Text('Archive')
                      ]),
                    ),
                    const PopupMenuItem<String>(
                      value: DELETE,
                      child: Row(children: [
                        Icon(
                          Icons.delete_outlined,
                          color: ColorManager.kDarkCharcoal,
                        ),
                        SizedBox(width: AppSize.s8),
                        Text('Delete')
                      ]),
                    ),
                    const PopupMenuItem<String>(
                      value: MUTE,
                      child: Row(children: [
                        Icon(
                          Icons.speaker,
                          color: ColorManager.kDarkCharcoal,
                        ),
                        SizedBox(width: AppSize.s8),
                        Text('Mute')
                      ]),
                    ),
                    const PopupMenuItem<String>(
                      value: REPORT,
                      child: Row(children: [
                        Icon(
                          Icons.flag_outlined,
                          color: ColorManager.kDarkCharcoal,
                        ),
                        SizedBox(width: AppSize.s8),
                        Text('Report')
                      ]),
                    ),
                    const PopupMenuItem<String>(
                      value: BLOCK,
                      child: Row(children: [
                        Icon(
                          Icons.not_interested,
                          color: ColorManager.kDarkCharcoal,
                        ),
                        SizedBox(width: AppSize.s8),
                        Text('Mute')
                      ]),
                    ),
                  ],
                  child: const Icon(
                    Icons.more_vert,
                    size: AppSize.s18,
                    color: ColorManager.kDarkCharcoal,
                  ),
                ),
                const SizedBox(width: AppSize.s16),
              ],
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: model.scrollController,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: model.chatList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Conversation conversation =
                          model.chatList.toList().reversed.toList()[index];

                      if (conversation.senderId != model.user?.id) {
                        return ReceiverChatWidget(chat: conversation);
                      }
                      return SenderChatWidget(chat: conversation);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                            hintText: 'Start typing here...',
                            fillColor: ColorManager.kWhiteColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: const BorderSide(
                                color: ColorManager.kGrey1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: const BorderSide(
                                color: ColorManager.kGrey1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: const BorderSide(
                                color: ColorManager.kGrey1,
                              ),
                            ),
                            controller: model.chatMessageController,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: model.busy(CREATE_CHAT)
                              ? () {}
                              : () => model.createChat(contact),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.send,
                              size: AppSize.s24,
                              color: model.busy(CREATE_CHAT)
                                  ? ColorManager.kGrey4
                                  : ColorManager.kDarkColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class ReceiverChatWidget extends StatelessWidget {
  const ReceiverChatWidget({
    super.key,
    required this.chat,
  });

  final Conversation chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppSize.s4,
              ),
              padding: const EdgeInsets.all(AppPadding.p10),
              decoration: const BoxDecoration(
                color: ColorManager.kSecondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
              ),
              child: Text(
                '${chat.message}',
                style: getRegularStyle(
                  color: ColorManager.kWhiteColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            DateFormat.Hm().format(DateTime.parse(chat.createdAt!)),
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }
}

class SenderChatWidget extends StatelessWidget {
  const SenderChatWidget({
    super.key,
    required this.chat,
  });

  final Conversation chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppSize.s4,
              ),
              padding: const EdgeInsets.all(AppPadding.p10),
              decoration: const BoxDecoration(
                color: ColorManager.kGrey1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
              ),
              child: Text(
                '${chat.message}',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Text(
            DateFormat.Hm().format(DateTime.parse(chat.createdAt!)),
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }
}
