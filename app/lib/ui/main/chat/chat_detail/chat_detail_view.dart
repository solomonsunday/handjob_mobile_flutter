import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'chat_detail_view_model.dart';

const String ARCHIVE = 'ARCHIVE';
const String DELETE = 'DELETE';
const String MUTE = 'MUTE';
const String REPORT = 'REPORT';
const String BLOCK = 'BLOCK';

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatDetailViewModel>.reactive(
        viewModelBuilder: () => ChatDetailViewModel(),
        onModelReady: (model) async {},
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.kWhiteColor,
              shadowColor: ColorManager.kGrey1,
              leading: GestureDetector(
                onTap: model.navigateBack,
                child: Icon(
                  Icons.arrow_back,
                  color: ColorManager.kDarkColor,
                ),
              ),
              titleSpacing: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Steven Okoro',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    'Online',
                    style: getRegularStyle(
                      color: ColorManager.kDarkCharcoal,
                      fontSize: FontSize.s11,
                    ),
                  ),
                ],
              ),
              actions: [
                Icon(
                  Icons.videocam,
                  size: AppSize.s24,
                  color: ColorManager.kDarkColor,
                ),
                SizedBox(width: AppSize.s16),
                Icon(
                  Icons.call,
                  size: AppSize.s24,
                  color: ColorManager.kDarkColor,
                ),
                SizedBox(width: AppSize.s16),
                PopupMenuButton(
                  onSelected: (String item) {},
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
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
                    PopupMenuItem<String>(
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
                    PopupMenuItem<String>(
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
                    PopupMenuItem<String>(
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
                    PopupMenuItem<String>(
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
                  child: Icon(
                    Icons.more_vert,
                    size: AppSize.s18,
                    color: ColorManager.kDarkCharcoal,
                  ),
                ),
                SizedBox(width: AppSize.s16),
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Text('Chat text');
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p24),
                    decoration: BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                            hintText: 'Start typing here...',
                            fillColor: ColorManager.kWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: BorderSide(
                                color: ColorManager.kDarkColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: BorderSide(
                                color: ColorManager.kGrey3,
                              ),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.attach_file),
                                ),
                                SizedBox(width: AppSize.s8),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.photo),
                                ),
                                SizedBox(width: AppSize.s16),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.mic,
                          size: AppSize.s24,
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
