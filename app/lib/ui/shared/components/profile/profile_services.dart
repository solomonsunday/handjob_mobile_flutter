import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/user.model.dart';

class ProfileServices extends StatelessWidget {
  const ProfileServices({
    Key? key,
    required this.currentUser,
    this.showServiceSheet,
  }) : super(key: key);
  final User? currentUser;
  final VoidCallback? showServiceSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileActionHeader(
            icon: Icons.tag,
            title: 'Services',
            onTap: showServiceSheet,
          ),
          const SizedBox(height: AppSize.s8),
          Wrap(
              spacing: 4,
              runSpacing: -10,
              runAlignment: WrapAlignment.start,
              clipBehavior: Clip.none,
              children: (currentUser?.services ?? [])
                  .map(
                    (service) => Chip(
                      label: Text(
                        service,
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
