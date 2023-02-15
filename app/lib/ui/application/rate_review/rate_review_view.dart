import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/application/application_view_model.dart';
import 'package:handjob_mobile/ui/application/rate_review/rate_review_view.form.dart';
import 'package:handjob_mobile/ui/application/rate_review/rate_review_view_model.dart';
import 'package:handjob_mobile/ui/shared/components/rating/rating.dart';
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
  FormDropdownField(
    name: 'rating',
    items: [
      StaticDropdownItem(title: '1.0', value: '1.0'),
      StaticDropdownItem(title: '2.0', value: '2.0'),
      StaticDropdownItem(title: '3.0', value: '3.0'),
      StaticDropdownItem(title: '4.0', value: '4.0'),
      StaticDropdownItem(title: '5.0', value: '5.0'),
    ],
  ),
])
class RateReviewView extends StatelessWidget with $RateReviewView {
  RateReviewView({
    super.key,
    required this.instantHire,
    required this.applicant,
  });

  final InstantJob instantHire;
  final Applicant applicant;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RateReviewViewModel>.reactive(
        viewModelBuilder: () => RateReviewViewModel(),
        onModelReady: (model) {
          listenToFormUpdated(model);
        },
        onDispose: (model) => disposeForm(),
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
              child: ListView(children: [
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
                          const SizedBox(width: AppSize.s12),
                          Rating(
                            value: double.parse(model.ratingValue ?? "0"),
                          ),
                        ],
                      ),
                      const Divider(),
                      if (model.hasError)
                        Text(
                          '${model.modelError}',
                          style: getRegularStyle(
                            color: ColorManager.kRed,
                            fontSize: FontSize.s12,
                          ),
                        ),
                      RateReviewFormView(
                        applicantId: applicant.applicantId!,
                        jobId: instantHire.id!,
                        nameController: nameController,
                        titleController: titleController,
                        descriptionController: descriptionController,
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

class RateReviewFormView extends ViewModelWidget<RateReviewViewModel> {
  const RateReviewFormView({
    super.key,
    required this.nameController,
    required this.titleController,
    required this.descriptionController,
    required this.jobId,
    required this.applicantId,
  });
  final String applicantId;
  final String jobId;
  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context, RateReviewViewModel model) {
    return Column(
      children: [
        InputField(
          label: 'Your name',
          hintText: 'e.g John Doe',
          keyBoardType: TextInputType.text,
          controller: nameController,
        ),
        const SizedBox(height: AppSize.s40),
        InputField(
          label: 'Review title',
          hintText: 'e.g example@gmail.com',
          keyBoardType: TextInputType.emailAddress,
          controller: titleController,
        ),
        const SizedBox(height: AppSize.s40),
        Textarea(
          label: 'Detail review',
          hintText: 'Describe your experience with this applicant',
          keyBoardType: TextInputType.text,
          controller: descriptionController,
          maxLines: 5,
          enabled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: ColorManager.kDarkColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        const SizedBox(height: AppSize.s40),
        DefaultDropDownField(
          hint: 'Rating',
          value: model.rating,
          dropdownItems: RatingValueToTitleMap.values.toList(),
          onChanged: (value) => model.handleRating(value!),
          buttonWidth: MediaQuery.of(context).size.width,
          buttonHeight: 50,
          buttonDecoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: ColorManager.kDarkColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        const SizedBox(height: AppSize.s40),
        DefaultButton(
          onPressed: model.isBusy
              ? null
              : () => model.submitReview(applicantId, jobId),
          title: 'Submit',
          // disabled: model.isBusy || model.isFormValid,
          busy: model.isBusy,
        ),
      ],
    );
  }
}
