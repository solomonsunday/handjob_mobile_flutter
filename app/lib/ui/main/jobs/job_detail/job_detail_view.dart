import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/jobs/job_detail/job_detail_view_model.dart';
import 'package:handjob_mobile/utils/contants.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/instant_job.model.dart';
import '../../../../models/user.model.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/humanize_date.dart';
import '../jobs_view.dart';

class JobDetailView extends StatelessWidget {
  const JobDetailView({
    super.key,
    required this.instantJob,
    required this.user,
  });

  final InstantJob instantJob;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JobDetailViewModel>.reactive(
        viewModelBuilder: () => JobDetailViewModel(),
        onViewModelReady: (model) {
          print('id: ${instantJob.id}');
          model.fetchAppliedJobs();
          model.getApplicants(instantJob.id!);
        },
        builder: (context, model, _) {
          return Scaffold(
            appBar: Navbar(
              leadingIcon: const Icon(
                Icons.arrow_back,
                color: ColorManager.kDarkColor,
              ),
              onTap: model.navigateBack,
              title: AppString.jobDetails,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p16,
                horizontal: AppPadding.p24,
              ),
              margin: const EdgeInsets.only(bottom: AppPadding.p2),
              decoration: const BoxDecoration(
                color: ColorManager.kWhiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: AppSize.s40,
                        height: AppSize.s40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xffd9d9d9),
                        ),
                        child: instantJob.company?.imageUrl == null
                            ? Image.asset('assets/images/logo.jpeg')
                            : CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/logo.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/logo.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                imageUrl: instantJob.company!.imageUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: AppSize.s8),
                      Text(
                        '${instantJob.company?.firstName} ${instantJob.company?.lastName}',
                        style: getBoldStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: ColorManager.kSecondaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: AppSize.s4),
                          Text(
                            instantJob.createdAt == null
                                ? ""
                                : humanizeDate(
                                    fromIsoToDateTime(instantJob.createdAt!)),
                            style: getRegularStyle(
                              fontSize: FontSize.s10,
                              color: ColorManager.kPrimary400Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s12),
                  Text(
                    '${instantJob.service}',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    '${instantJob.description}',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s12,
                    ),
                  ),
                  SizedBox(height: AppSize.s20),
                  Wrap(
                    children: [
                      Text(
                        'MEET UP LOCATION: ${instantJob.meetupLocation ?? instantJob.address ?? "NA"}',
                        style: getBoldStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded),
                          const SizedBox(width: AppSize.s4),
                          Text(
                            instantJob.startDate == null
                                ? ""
                                : DateFormat.yMEd().format(
                                    DateTime.parse(instantJob.startDate!)),
                            style: getMediumStyle(
                                color: ColorManager.kDarkCharcoal),
                          ),
                        ],
                      ),
                      const SizedBox(width: AppSize.s4),
                      Row(
                        children: [
                          const Icon(Icons.pin_drop_outlined),
                          const SizedBox(width: AppSize.s4),
                          Expanded(
                            child: Text(
                              instantJob.address ?? "",
                              softWrap: true,
                              maxLines: 2,
                              style: getMediumStyle(
                                  color: ColorManager.kDarkCharcoal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (instantJob.company?.id == user.id)
                        Text(
                          'You created this job',
                          style: getRegularStyle(
                            color: ColorManager.kDarkCharcoal,
                          ),
                        ),
                      if (model.currentUser?.accountType ==
                          ACCOUNT_INSTANT_HIRE)
                        model.busy(FETCH_APPLICANTS)
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : Text('${model.applicantCount} Applicants'),
                      if (instantJob.company?.id != user.id &&
                          !model.isJobApplied(instantJob.id ?? "") &&
                          !model.isWaitingToBeAccepted &&
                          model.currentUser?.accountType !=
                              ACCOUNT_INSTANT_HIRE)
                        DefaultButton(
                          onPressed: model.busy(APPLY_JOB)
                              ? null
                              : () => model.applyInstantJob(instantJob!.id!),
                          disabled: model.busy(APPLY_JOB),
                          busy: model.busy(APPLY_JOB),
                          title: 'Apply',
                          buttonType: ButtonType.fill,
                          paddingHeight: 8,
                          paddingWidth: 20,
                          borderRadius: 4,
                          fontSize: 12,
                        ),
                      if (model.isWaitingToBeAccepted)
                        Text(
                          'Waiting to be accepted',
                          style: getBoldStyle(
                            color: ColorManager.kSecondaryColor,
                            fontSize: FontSize.s11,
                          ),
                        ),
                      if (model.isJobApplied(instantJob.id ?? ''))
                        DefaultButton(
                          onPressed: null,
                          title: 'Applied',
                          trailingIcon: Icons.check,
                          trailingIconColor: ColorManager.kWhiteColor,
                          trailingIconSpace: 8,
                          buttonType: ButtonType.fill,
                          buttonBgColor: ColorManager.kGreen,
                          buttonTextColor: ColorManager.kWhiteColor,
                          paddingHeight: 20,
                          paddingWidth: 40,
                          borderRadius: 4,
                        ),

                      const SizedBox(width: AppSize.s8),
                      // Text(
                      //   'Awaiting response...',
                      //   style: getRegularStyle(
                      //     color: ColorManager.kPrimary200Color,
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
