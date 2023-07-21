import 'package:flutter/material.dart';
import 'package:handjob_mobile/sheets/ongoing_voice_call/ongoing_voice_call_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

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
                child: Image.asset(
                  'assets/images/call_avatar.png',
                  fit: BoxFit.cover,
                  // width: AppSize.s120,
                  // height: AppSize.s120,
                ),
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                'Steve Okoro',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                '3:14',
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: const BoxDecoration(
                        color: ColorManager.kTransparent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chat,
                        size: AppSize.s32,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: const BoxDecoration(
                        color: ColorManager.kTransparent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.videocam,
                        size: AppSize.s32,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.call_end,
                      size: AppSize.s24,
                      color: ColorManager.kWhiteColor,
                    ),
                    backgroundColor: ColorManager.kRed,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: const BoxDecoration(
                        color: ColorManager.kTransparent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.campaign,
                        size: AppSize.s32,
                        color: ColorManager.kDarkCharcoal,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: const BoxDecoration(
                        color: ColorManager.kTransparent,
                        // color: ColorManager.kBackgroundolor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mic,
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
