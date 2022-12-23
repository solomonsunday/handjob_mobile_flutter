import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'notification_view_model.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      builder: (_, model, child) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: AppSize.s12),
              child: DefaultCheckBox(
                value: false,
                onChanged: (value) {},
                richText: RichText(
                  text: TextSpan(
                    text: 'Mark all as read',
                    style: getRegularStyle(
                      color: ColorManager.kGrey4,
                      fontSize: FontSize.s9,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (_, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppPadding.p10,
                      horizontal: AppPadding.p24,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: ColorManager.kDarkColor,
                    ),
                    title: Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Rachel Mobolaji',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s12,
                            ),
                          ),
                          SizedBox(width: AppSize.s12),
                          Text(
                            'sent you a contact request',
                            style: getRegularStyle(
                              color: ColorManager.kGrey4,
                              fontSize: FontSize.s11,
                            ),
                          )
                        ],
                      ),
                    ),
                    subtitle: Text(
                      '7 mins ago',
                      style: getRegularStyle(
                        color: ColorManager.kGrey4,
                        fontSize: FontSize.s11,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
