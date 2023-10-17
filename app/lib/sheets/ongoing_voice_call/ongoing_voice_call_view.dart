import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/sheets/ongoing_voice_call/ongoing_voice_call_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../models/contact.model.dart';
import '../../utils/contants.dart';

class OngoingVoiceCallView extends StatelessWidget {
  const OngoingVoiceCallView({
    super.key,
    this.request,
    this.completer,
  });

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OngoingVoiceCallModel>.reactive(
      viewModelBuilder: () => OngoingVoiceCallModel(),
      onViewModelReady: (model) async {
        if (request?.data != null) {
          print('request data: ${request?.data}');
          Contact contact = request?.data['contact'];
          String callRole = request?.data['call_role'] as String;
          print('voice call => contact: ${contact.toJson()}');
          print('call role => ' + callRole);
          model.updateContact(contact);
          model.updateCallRole(callRole);

          model.initEngine();
        }
      },
      onDispose: (model) {
        model.dispose();
      },
      builder: (context, model, _) {
        return BottomSheetContainer(
          showClose: false,
          onClose: () => completer!(SheetResponse(confirmed: false)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSize.s120),
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: model.contact?.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: model.contact?.imageUrl ?? '',
                        fit: BoxFit.cover,
                      )
                    : ClipOval(
                        child: Image.asset(
                          'assets/images/default-avatar.jpeg',
                          fit: BoxFit.cover,

                          // width: AppSize.s120,
                          // height: AppSize.s120,
                        ),
                      ),
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                '${model.contact?.firstName} ${model.contact?.lastName}',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                model.callStatus,
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: const EdgeInsets.all(AppPadding.p16),
                  //     decoration: const BoxDecoration(
                  //       color: ColorManager.kTransparent,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: const Icon(
                  //       Icons.chat,
                  //       size: AppSize.s32,
                  //       color: ColorManager.kDarkCharcoal,
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: const EdgeInsets.all(AppPadding.p16),
                  //     decoration: const BoxDecoration(
                  //       color: ColorManager.kTransparent,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: const Icon(
                  //       Icons.videocam,
                  //       size: AppSize.s32,
                  //       color: ColorManager.kDarkCharcoal,
                  //     ),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: model.switchSpeakerphone,
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: BoxDecoration(
                        color: model.inSpeakerMode
                            ? ColorManager.kBackgroundolor
                            : ColorManager.kTransparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        model.inSpeakerMode
                            ? Icons.volume_up
                            : Icons.volume_down,
                        size: AppSize.s32,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () => model.leaveChannel(completer),
                    // onPressed: model.isJoined
                    //     ? () => model.leaveChannel(completer)
                    //     : model.joinChannel,
                    child: model.busy(JOIN_CHANNEL) && !model.isJoined
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.call_end,
                            size: AppSize.s24,
                            color: ColorManager.kWhiteColor,
                          ),
                    backgroundColor: model.isJoined
                        ? ColorManager.kRed
                        : ColorManager.kTransparent,
                  ),
                  GestureDetector(
                    onTap: model.switchMicrophone,
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: BoxDecoration(
                        // color: ColorManager.kTransparent,
                        color: model.isMuted
                            ? ColorManager.kBackgroundolor
                            : ColorManager.kTransparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        model.isMuted ? Icons.mic_off : Icons.mic,
                        size: AppSize.s32,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s80)
            ],
          ),
        );
      },
    );
  }
}
