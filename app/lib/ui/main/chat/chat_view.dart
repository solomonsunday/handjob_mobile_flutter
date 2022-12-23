import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../models/instant_job.model.dart';
import 'chat_view_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        viewModelBuilder: () => ChatViewModel(),
        onModelReady: (model) async {},
        builder: (context, model, child) {
          return Scaffold(
            appBar: Navbar(
              leadingIcon: Icon(
                Icons.arrow_back,
                color: ColorManager.kDarkColor,
              ),
              onTap: model.navigateBack,
              title: AppString.allChats,
            ),
            body: Container(
              // height: MediaQuery.of(context).si,
              decoration: BoxDecoration(
                color: ColorManager.kSecondary100Color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: AppSize.s8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s12,
                      vertical: AppSize.s12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: InputField(
                      hintText: 'Search',
                      paddingBottom: AppPadding.p8,
                      paddingTop: AppPadding.p8,
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorManager.kGrey3,
                      ),
                      onChanged: model.handleSearch,
                    ),
                  ),
                  SizedBox(height: AppSize.s8),
                  if (model.isBusy)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        // Chat chat = model.chats[index];
                        if (index > 3) {
                          return ChatItem(time: 'Thur');
                        }
                        return ChatItem(
                          onTap: model.navigateToChatDetail,
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
    this.time,
    this.onTap,
  }) : super(key: key);
  final String? time;
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
        margin: EdgeInsets.only(bottom: AppPadding.p2),
        decoration: BoxDecoration(
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
                color: Color(0xffd9d9d9),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://xsgames.co/randomusers/avatar.php?g=male'),
                ),
              ),
            ),
            SizedBox(width: AppSize.s8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: AppSize.s8),
                  Text(
                    'Steven Okoro',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    'Thanks for your service',
                    style: getRegularStyle(
                      color: ColorManager.kDarkCharcoal,
                      fontSize: FontSize.s12,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: AppSize.s12),
            Column(
              children: [
                Text(
                  time ?? '21:44',
                  style: getRegularStyle(
                    color: ColorManager.kDarkCharcoal,
                    fontSize: FontSize.s8,
                  ),
                ),
                if (time == null)
                  Container(
                    padding: EdgeInsets.all(AppSize.s6),
                    decoration: BoxDecoration(
                      color: ColorManager.kSecondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '1',
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
