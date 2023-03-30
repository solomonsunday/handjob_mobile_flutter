import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/ui/main/jobs/jobs_view_model.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:handjob_mobile/utils/humanize_date.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../app/app.locator.dart';
import '../../../enums/bottom_sheet_type.dart';
import '../../../models/applied_job.model.dart';
import '../../../models/instant_job.model.dart';
import '../../../models/user.model.dart';
import '../../../services/authentication.service.dart';
import '../../../services/instant_job.service.dart';
import '../../../utils/http_exception.dart';
import '../../skeletons/post_view.skeleton.dart';

class JobsView extends StatelessWidget {
  const JobsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JobsViewModel>.reactive(
        viewModelBuilder: () => JobsViewModel(),
        onModelReady: (model) async {
          await model.getInstantJobs();
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: Navbar(
              leadingIcon: const Icon(
                Icons.arrow_back,
                color: ColorManager.kDarkColor,
              ),
              onTap: model.navigateBack,
              title: AppString.allInstantJobTitle,
            ),
            body: Container(
              // height: MediaQuery.of(context).si,
              decoration: BoxDecoration(
                color: ColorManager.kSecondary100Color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: AppSize.s8),
                  if (model.jobs.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.s12,
                        vertical: AppSize.s8,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorManager.kWhiteColor,
                      ),
                      child: SearchInput(
                        hintText: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.kGrey3,
                        ),
                        onChanged: model.handleSearch,
                      ),
                    ),
                  const SizedBox(height: AppSize.s8),
                  if (model.isBusy) const Expanded(child: PostViewSkeleton()),
                  if (model.jobs.isEmpty)
                    const Center(child: Text('There are no jobs yet!')),
                  if (!model.isBusy)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.jobs.length,
                        itemBuilder: (BuildContext context, int index) {
                          InstantJob instantJob = model.jobs[index];
                          return JobItem(
                            instantJob: instantJob,
                            user: model.currentUser!,
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}

class JobItem extends StatelessWidget {
  const JobItem({
    Key? key,
    required this.instantJob,
    required this.user,
  }) : super(key: key);

  final InstantJob instantJob;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JobItemViewModel>.reactive(
        viewModelBuilder: () => JobItemViewModel(),
        builder: (context, model, child) {
          return GestureDetector(
            onTap: instantJob.company?.id == user.id
                ? () => model.showEditInstantJob(instantJob)
                : () => model.navigateToJobDetail(instantJob),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p16,
                horizontal: AppPadding.p24,
              ),
              margin: EdgeInsets.only(bottom: AppPadding.p2),
              decoration: BoxDecoration(
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
                          color: Color(0xffd9d9d9),
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
                      GestureDetector(
                        onTap: () => model.navigateToAuthorProfile(
                            instantJob.company?.id ?? ""),
                        child: Text(
                          '${instantJob.company?.firstName} ${instantJob.company?.lastName}',
                          style: getBoldStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s12,
                          ),
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
                            humanizeDate(
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
                            DateFormat.yMEd()
                                .format(DateTime.parse(instantJob.startDate!)),
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
                      if (instantJob?.company?.id != user.id &&
                          !model.isJobApplied(instantJob?.id ?? "") &&
                          !model.isWaitingToBeAccepted)
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

                      if (model.isJobApplied(instantJob.id!))
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

const String APPLY_JOB = "APPLY_JOB";

class JobItemViewModel extends BaseViewModel {
  final _instantJobService = locator<InstantJobService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  bool _isWaitingToBeAccepted = false;
  bool get isWaitingToBeAccepted => _isWaitingToBeAccepted;

  List<AppliedJob>? get appliedJobs => _instantJobService.appliedJobs;
  User? get user => _authenticationService.currentUser;

  User? get currentUser => _authenticationService.currentUser;

  Future applyInstantJob(String jobId) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want to apply for this job?",
    );
    if (!response!.confirmed) return;

    if ((user?.phoneNumber ?? "").isEmpty) {
      _dialogService.showDialog(
        description:
            "Kindly add your phone number in your profile to apply for this job.",
        title: "Phone number required",
      );
      return;
    }

    try {
      setBusyForObject(APPLY_JOB, true);
      await _instantJobService.applyInstantJob({"jobId": jobId});
      await _instantJobService.getCurrentInstantJobs();
      Fluttertoast.showToast(
        msg: 'Job applied successfully!',
        toastLength: Toast.LENGTH_LONG,
        fontSize: FontSize.s16,
      );
      _isWaitingToBeAccepted = true;
    } on DioError catch (error) {
      // print('error.response?.data: ${error.response?.data}');
      _isWaitingToBeAccepted = false;
      _dialogService.showDialog(
        description: error.response?.data['message'],
        title: "An error occured",
      );
      // throw HttpException(error.response?.data['message'] ?? "");
    } finally {
      setBusyForObject(APPLY_JOB, false);
      notifyListeners();
    }
  }

  bool isJobApplied(String id) {
    return (appliedJobs ?? [])
        .where((element) => element.jobId == id)
        .toList()
        .isNotEmpty;
  }

  showEditInstantJob(InstantJob data) async {
    var response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.edit_instant_job,
      data: data,
      // isScrollControlled: true,
      ignoreSafeArea: true,
      enterBottomSheetDuration: const Duration(milliseconds: 400),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      enableDrag: true,
    );
    if (response?.confirmed ?? false) {
      InstantJob job = response?.data as InstantJob;
      data.address = job.address;
      data.meetupLocation = job.meetupLocation;
      data.now = job.now;
      notifyListeners();
    }
  }

  navigateToJobDetail(InstantJob instantJob) => _navigationService.navigateTo(
        Routes.jobDetailView,
        arguments: JobDetailViewArguments(
          instantJob: instantJob,
          user: currentUser!,
        ),
      );

  navigateToAuthorProfile(String id) =>
      _navigationService.navigateToApplicantProfileView(applicantId: id);
}
