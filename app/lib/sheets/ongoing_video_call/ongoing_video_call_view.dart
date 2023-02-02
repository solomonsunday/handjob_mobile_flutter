import 'package:flutter/material.dart';
import 'package:handjob_mobile/sheets/incoming_call/incoming_call_view_model.dart';
import 'package:handjob_mobile/sheets/ongoing_video_call/ongoing_video_call_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

class OngoingVideoCallView extends StatelessWidget {
  const OngoingVideoCallView({
    super.key,
    this.request,
    this.completer,
  });

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OngoingVideoCallViewModel>.reactive(
      viewModelBuilder: () => OngoingVideoCallViewModel(),
      builder: (context, model, _) {
        return BottomSheetContainer(
          showClose: false,
          padding: EdgeInsets.zero,
          onClose: () => completer!(SheetResponse(confirmed: false)),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/dorell.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: AppSize.s60,
                right: AppSize.s16,
                child: Container(
                  height: 104,
                  width: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s4),
                    ),
                    child: Image.asset(
                      'assets/images/charles.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
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
                            color: ColorManager.kWhiteColor,
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
                            color: ColorManager.kWhiteColor,
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
                            color: ColorManager.kWhiteColor,
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
                            color: ColorManager.kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s80)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
