import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/applicant.model.dart';
import 'package:handjob_mobile/services/instant_job.service.dart';
import 'package:handjob_mobile/ui/application/application_view_model.dart';
import 'package:handjob_mobile/ui/shared/components/rating/rating.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/applied_job.model.dart';
import '../../models/instant_job.model.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key, required this.instantHire});

  final InstantJob instantHire;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationViewModel>.reactive(
        viewModelBuilder: () => ApplicationViewModel(),
        onModelReady: (model) => model.getApplicants(instantHire.id!),
        builder: (context, model, _) {
          print(
              'applicants: ${model.applicants?.map((e) => e.toJson()).toList()}');
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
                'Applications',
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Job description',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          const SizedBox(height: AppSize.s24),
                          Text(
                            '${instantHire.service} at ${instantHire.location}',
                            style: getBoldStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          Text(
                            instantHire.description ?? "",
                            style: getRegularStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s12,
                            ),
                          ),
                          const SizedBox(height: AppSize.s20),
                          Text(
                            'MEET UP LOCATION: ${instantHire.meetupLocation ?? instantHire.location}',
                            style: getMediumStyle(
                              color: ColorManager.kDarkColor,
                              fontSize: FontSize.s12,
                            ),
                          ),
                          const SizedBox(height: AppSize.s12),
                          Row(
                            children: [
                              DefaultButton(
                                onPressed: () {},
                                title:
                                    '${DateFormat.yMEd().format(DateTime.parse(instantHire.startDate!))}  - ${DateFormat.yMEd().format(DateTime.parse(instantHire.endDate!))}',
                                leadingIcon:
                                    const Icon(Icons.calendar_month_rounded),
                                leadingIconColor: ColorManager.kSecondaryColor,
                                buttonType: ButtonType.outline,
                                paddingHeight: 12,
                                paddingWidth: 4,
                                borderRadius: 4,
                              ),
                              const SizedBox(width: AppSize.s4),
                            ],
                          ),
                          const SizedBox(height: AppSize.s8),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s24),
                    Text(
                      'Applications',
                      style: getBoldStyle(
                        color: ColorManager.kDarkColor,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const SizedBox(height: AppSize.s24),
                    if (model.isBusy)
                      const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: ColorManager.kPrimary100Color,
                          valueColor: AlwaysStoppedAnimation(
                              ColorManager.kPrimaryColor),
                        ),
                      ),
                    if ((model.applicants ?? []).isEmpty && !model.isBusy)
                      Text(
                        'No applicant available yet!',
                        style: getSemiBoldStyle(
                          color: ColorManager.kDarkCharcoal,
                        ),
                      ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: (model.applicants ?? []).length,
                      itemBuilder: (context, index) {
                        Applicant applicant = (model.applicants ?? [])[index];
                        return ApplicantItem(
                          applicant: applicant,
                          instantHire: instantHire,
                        );
                      },
                    ))
                  ]),
            ),
          );
        });
  }
}

class ApplicantItem extends StatelessWidget {
  const ApplicantItem({
    super.key,
    required this.applicant,
    required this.instantHire,
  });
  final Applicant applicant;
  final InstantJob instantHire;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicantItemViewModel>.reactive(
        viewModelBuilder: () => ApplicantItemViewModel(),
        builder: (context, model, _) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: AppSize.s32,
                          child: Image.asset('assets/images/logo.jpeg'),
                        ),
                        SizedBox(
                          width: AppSize.s14,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSize.s8),
                            Text(
                              applicant.name!,
                              style: getBoldStyle(
                                color: ColorManager.kDarkColor,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            SizedBox(height: AppSize.s2),
                            Text(
                              '${applicant.occupation ?? ""} at ${applicant.location ?? ""}',
                              style: getRegularStyle(
                                color: ColorManager.kDarkColor,
                              ),
                            ),
                            const SizedBox(height: AppSize.s2),
                            const Rating(),
                            const SizedBox(height: AppSize.s4)
                          ],
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () =>
                              model.navigateToApplicantProfile(applicant),
                          child: Text(
                            'View profile',
                            style: getRegularStyle(
                              color: ColorManager.kDarkCharcoal,
                              fontSize: FontSize.s11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!applicant.accepted! && !applicant.rejected!)
                      Row(
                        children: [
                          DefaultButton(
                            onPressed: model.busy(ACCEPT_APPLICANT)
                                ? null
                                : () => model.acceptApplication(
                                    applicant, instantHire.id!),
                            title: 'Accept',
                            buttonType: ButtonType.outline,
                            paddingHeight: 12,
                            busy: model.busy(ACCEPT_APPLICANT),
                            disabled: model.busy(ACCEPT_APPLICANT),
                          ),
                          const SizedBox(width: AppSize.s8),
                          DefaultButton(
                            onPressed: model.busy(REJECT_APPLICANT)
                                ? null
                                : () => model.rejectApplication(
                                    applicant, instantHire.id!),
                            title: 'Reject',
                            buttonType: ButtonType.outline,
                            paddingHeight: 12,
                            busy: model.busy(REJECT_APPLICANT),
                            disabled: model.busy(REJECT_APPLICANT),
                          ),
                        ],
                      ),
                    if (applicant.accepted!)
                      Row(
                        children: [
                          DefaultButton(
                            onPressed: () {},
                            title: 'Accepted',
                            trailingIconColor: Colors.white,
                            paddingHeight: 12,
                            buttonType: ButtonType.fill,
                            buttonBgColor: ColorManager.kSecondaryColor,
                          ),
                          const SizedBox(width: AppSize.s8),
                          DefaultButton(
                            onPressed: () => model.navigatoToRateReview(
                                instantHire, applicant),
                            title: 'Leave a review',
                            buttonType: ButtonType.outline,
                            paddingHeight: 12,
                            buttonTextColor: ColorManager.kDarkCharcoal,
                            buttonBgColor: ColorManager.kWhiteColor,
                          ),
                        ],
                      ),
                    if (applicant.rejected!)
                      Row(
                        children: [
                          DefaultButton(
                            onPressed: () {},
                            title: 'Rejected',
                            trailingIconColor: Colors.white,
                            paddingHeight: 12,
                            buttonType: ButtonType.fill,
                            buttonBgColor: ColorManager.kRed,
                          ),
                        ],
                      )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

const String ACCEPT_APPLICANT = "ACCEPT_APPLICANT";
const String REJECT_APPLICANT = "REJECT_APPLICANT";

class ApplicantItemViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();

  acceptApplication(Applicant applicant, String jobId) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want accept this applicant?",
    );
    if (!response!.confirmed) return;
    setBusyForObject(ACCEPT_APPLICANT, true);
    var formData = {"jobId": jobId};
    try {
      await _instantJobService.acceptApplication(
          applicant.applicationId!, formData);
      applicant.accepted = true;
    } finally {
      setBusyForObject(ACCEPT_APPLICANT, false);
    }
  }

  rejectApplication(Applicant applicant, String jobId) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want reject this applicant?",
    );
    if (!response!.confirmed) return;
    setBusyForObject(REJECT_APPLICANT, false);
    var formData = {"jobId": jobId};
    await _instantJobService.rejectApplication(
        applicant.applicationId!, formData);
    applicant.rejected = true;
    setBusyForObject(REJECT_APPLICANT, false);
  }

  navigatoToRateReview(InstantJob instantHire, Applicant applicant) {
    _navigationService.navigateTo(Routes.rateReviewView,
        arguments: RateReviewViewArguments(
          instantHire: instantHire,
          applicant: applicant,
        ));
  }

  navigateToApplicantProfile(Applicant applicant) {
    _navigationService.navigateToApplicantProfileView(
        applicantId: applicant.applicantId!);
  }
}
