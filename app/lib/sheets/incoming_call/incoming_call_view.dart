import 'package:flutter/material.dart';
import 'package:handjob_mobile/sheets/incoming_call/incoming_call_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../models/contact.model.dart';

class IncomingCallView extends StatelessWidget {
  const IncomingCallView({
    super.key,
    this.request,
    this.completer,
  });

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IncomingCallViewModel>.reactive(
      viewModelBuilder: () => IncomingCallViewModel(),
      onViewModelReady: (model) {
        if (request?.data != null) {
          Contact contact = request?.data['contact'];
          model.updateContact(contact);
        }
      },
      builder: (context, model, _) {
        return BottomSheetContainer(
          showClose: false,
          onClose: () => completer!(SheetResponse(confirmed: false)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSize.s120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  request?.data['type'] == "video"
                      ? const Icon(
                          Icons.videocam,
                          size: AppSize.s60,
                        )
                      : const Icon(
                          Icons.phone,
                          size: AppSize.s60,
                        ),
                  const SizedBox(width: AppSize.s12),
                  Text(
                    '${request?.title}',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s120),
              // Container(
              //   width: 140,
              //   height: 140,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              //   child: Image.asset(
              //     'assets/images/call_avatar.png',
              //     fit: BoxFit.cover,
              //     // width: AppSize.s120,
              //     // height: AppSize.s120,
              //   ),
              // ),
              const SizedBox(height: AppSize.s12),
              Text(
                '${model.contact?.firstName} ${model.contact?.lastName}',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(height: AppSize.s120),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => model.rejectCall(completer),
                    child: const Icon(
                      Icons.call_end,
                      size: AppSize.s24,
                      color: ColorManager.kWhiteColor,
                    ),
                    backgroundColor: ColorManager.kRed,
                  ),
                  FloatingActionButton(
                    onPressed: () => model.acceptCall(completer),
                    child: const Icon(
                      Icons.call,
                      size: AppSize.s24,
                      color: ColorManager.kWhiteColor,
                    ),
                    backgroundColor: ColorManager.kSecondaryColor,
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
