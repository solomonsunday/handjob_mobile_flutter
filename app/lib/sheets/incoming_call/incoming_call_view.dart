import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

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
    return DraggableScrollableSheet(
        initialChildSize: 5.0,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.only(
              top: AppSize.s160,
              left: AppSize.s28,
              right: AppSize.s28,
              bottom: AppSize.s100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: AppSize.s24,
                    ),
                    Text(
                      '${request?.title}',
                      style: getRegularStyle(
                        color: ColorManager.kGrey1,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s80),
                Container(
                  width: AppSize.s120,
                  height: AppSize.s120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/call_avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: AppSize.s120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.phone_missed,
                        size: AppSize.s24,
                        color: ColorManager.kWhiteColor,
                      ),
                      backgroundColor: ColorManager.kRed,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.phone,
                        size: AppSize.s24,
                        color: ColorManager.kWhiteColor,
                      ),
                      backgroundColor: ColorManager.kSecondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
