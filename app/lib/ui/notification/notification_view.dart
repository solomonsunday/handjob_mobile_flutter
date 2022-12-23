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
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index) {
            if (index == 0)
              return Container(
                child: DefaultCheckBox(
                  value: false,
                  onChanged: (value) {},
                  richText: RichText(
                    text: TextSpan(text: 'Rachel Mobolaji'),
                  ),
                ),
              );
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: ColorManager.kDarkColor,
              ),
              title: Expanded(
                child: Row(
                  children: [
                    Text('Rachel Mobolaji'),
                  ],
                ),
              ),
              subtitle: Text('7 minutes'),
            );
          },
        ),
      ),
    );
  }
}
