import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/application/application_view_model.dart';
import 'package:handjob_mobile/ui/rating/rating.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import '../../../models/applicant.model.dart';
import '../../../models/instant_job.model.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'title'),
  FormTextField(name: 'description'),
])
class RateReviewView extends StatelessWidget {
  const RateReviewView({
    super.key,
    required this.instantHire,
    required this.applicant,
  });

  final InstantJob instantHire;
  final Applicant applicant;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationViewModel>.nonReactive(
        viewModelBuilder: () => ApplicationViewModel(),
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
                'Rate and Review',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              backgroundColor: ColorManager.kWhiteColor,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p24,
                vertical: AppPadding.p40,
              ),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: AppPadding.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Job ID',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          Text(
                            instantHire.id ?? "",
                            style: getRegularStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Job closed',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          Text(
                            DateFormat.yMEd()
                                .format(DateTime.parse(instantHire.endDate!)),
                            style: getRegularStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Applicant',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          Text(
                            applicant.name ?? '',
                            style: getRegularStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s24),
                      Text(
                        'Leave feedback about this artisan',
                        style: getBoldStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      SizedBox(height: AppSize.s24),
                      Row(
                        children: [
                          Text(
                            'Rate this applicant',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          Rating(),
                        ],
                      ),
                      Divider(),
                      InputField(
                        label: 'Your name',
                        hintText: 'e.g example@gmail.com',
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: AppSize.s40),
                      InputField(
                        label: 'Review title',
                        hintText: 'e.g example@gmail.com',
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: AppSize.s40),
                      Textarea(
                        label: 'Detail review',
                        hintText:
                            'Describe your experience with this applicant',
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: AppSize.s40),
                      DefaultButton(
                        onPressed: () {},
                        title: 'Submit',
                        disabled: true,
                        busy: false,
                      ),
                      const SizedBox(height: AppSize.s8),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s24),
              ]),
            ),
          );
        });
  }
}
