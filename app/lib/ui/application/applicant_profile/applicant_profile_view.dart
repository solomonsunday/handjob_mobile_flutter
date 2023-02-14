import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/application/applicant_profile/applicant_profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ApplicantProfileView extends StatelessWidget {
  const ApplicantProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicantProfileViewModel>.reactive(
        viewModelBuilder: () => ApplicantProfileViewModel(),
        onModelReady: (model) {},
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: model.goBack,
                child: const Icon(
                  Icons.arrow_back,
                  color: ColorManager.kDarkColor,
                ),
              ),
              title: Text(
                'Profile',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              backgroundColor: ColorManager.kWhiteColor,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: ListView(
              children: [],
            ),
          );
        });
  }
}
