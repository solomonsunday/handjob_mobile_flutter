import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/conversation.model.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:skeletons/skeletons.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'chat_view_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        viewModelBuilder: () => ChatViewModel(),
        onModelReady: (model) {
          model.initializeView();
          model.getConversationList();
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ColorManager.kWhiteColor,
            appBar: Navbar(
              leadingIcon: const Icon(
                Icons.arrow_back,
                color: ColorManager.kDarkColor,
              ),
              onTap: model.navigateBack,
              title: AppString.allChats,
            ),
            body: Container(
              // // height: MediaQuery.of(context).si,
              // decoration: BoxDecoration(
              //   color: ColorManager.kSecondary100Color,
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: AppSize.s8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s12,
                      vertical: AppSize.s12,
                    ),
                    decoration: const BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: SearchInput(
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorManager.kGrey3,
                      ),
                      onChanged: model.handleSearch,
                    ),
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: AppSize.s4),
                  if (model.isBusy) Expanded(child: SkeletonListView()),
                  if (!model.isBusy)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.conversations.length,
                        itemBuilder: (BuildContext context, int index) {
                          Conversation conversation =
                              model.conversations[index];
                          return ChatItem(
                            unReadCount: conversation.unReadCount ?? 0,
                            imgUrl: conversation.partner?.imageUrl,
                            firstName: conversation.partner?.firstName ?? '',
                            lastName: conversation.partner?.lastName ?? '',
                            message: conversation.message ?? '',
                            createdAt: conversation.createdAt,
                            onTap: () =>
                                model.navigateToChatDetail(conversation),
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    this.imgUrl,
    required this.unReadCount,
    required this.firstName,
    required this.lastName,
    required this.message,
    this.createdAt,
    required this.onTap,
  }) : super(key: key);

  final int unReadCount;
  final String? imgUrl;
  final String firstName;
  final String lastName;
  final String message;
  final String? createdAt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p16,
          horizontal: AppPadding.p24,
        ),
        margin: const EdgeInsets.only(bottom: AppPadding.p2),
        decoration: const BoxDecoration(
          color: ColorManager.kWhiteColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppSize.s40,
              height: AppSize.s40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xffd9d9d9),
              ),
              child: imgUrl == null
                  ? Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/default-avatar.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      imageUrl: imgUrl ?? "",
                      imageBuilder: (context, imageProvider) => Container(
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
            const SizedBox(width: AppSize.s8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: AppSize.s8),
                  Text(
                    '$firstName $lastName',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    message,
                    style: getRegularStyle(
                      color: ColorManager.kDarkCharcoal,
                      fontSize: FontSize.s12,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSize.s12),
            Column(
              children: [
                Text(
                  getTimeDiff(createdAt!),
                  style: getRegularStyle(
                    color: ColorManager.kDarkCharcoal,
                    fontSize: FontSize.s8,
                  ),
                ),
                if (unReadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(AppSize.s6),
                    decoration: const BoxDecoration(
                      color: ColorManager.kSecondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unReadCount',
                      style: getSemiBoldStyle(
                        color: ColorManager.kWhiteColor,
                        fontSize: FontSize.s8,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
