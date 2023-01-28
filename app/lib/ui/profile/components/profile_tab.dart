import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/models/review.model.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:handjob_mobile/utils/humanize_date.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

import '../../../models/applied_job.model.dart';
import '../../../models/instant_job.model.dart';

class ProfileTab extends ViewModelWidget<ProfileViewModel> {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
      ),
      child: TabBarView(
        children: [
          ListView.builder(
            itemCount: model.appliedJobs.length,
            itemBuilder: (context, index) {
              AppliedJob appliedJob = model.appliedJobs[index];
              return AppliedJobTabItem(appliedJob: appliedJob);
            },
          ),
          ListView.builder(
            itemCount: model.instantHires.length,
            itemBuilder: (context, index) {
              return TabItem(instantHire: model.instantHires[index]);
            },
          ),
          ListView.builder(
            itemCount: model.currentUser?.reviews?.length ?? 0,
            itemBuilder: (context, index) {
              return ReviewItem(
                review: (model.currentUser?.reviews ?? [])[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    required this.instantHire,
  }) : super(key: key);
  final InstantJob instantHire;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.jpeg'),
                  radius: 16,
                ),
              ),
              SizedBox(width: AppSize.s8),
              Text(
                instantHire.company?.companyName ?? "",
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
                  SizedBox(width: AppSize.s4),
                  Text(
                    '5 mins ago',
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
            instantHire.description ?? "",
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            instantHire.service ?? "",
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s20),
          Text(
            'MEET UP LOCATION: ${instantHire.meetupLocation}',
            style: getBoldStyle(
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
                leadingIcon: const Icon(Icons.calendar_month_rounded),
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
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     // DefaultButton(
          //     //   onPressed: () {},
          //     //   title: 'Applied',
          //     //   trailingIcon: Icons.check,
          //     //   trailingIconColor: ColorManager.kSecondaryColor,
          //     //   buttonType: ButtonType.outline,
          //     //   paddingHeight: 12,
          //     //   paddingWidth: 4,
          //     //   borderRadius: 4,
          //     // ),
          //     // const SizedBox(width: AppSize.s8),
          //     // Text(
          //     //   'Awaiting response...',
          //     //   style: getRegularStyle(
          //     //     color: ColorManager.kPrimary200Color,
          //     //   ),
          //     // )
          //   ],
          // ),
        ],
      ),
    );
  }
}

class AppliedJobTabItem extends StatelessWidget {
  const AppliedJobTabItem({
    Key? key,
    required this.appliedJob,
  }) : super(key: key);
  final AppliedJob appliedJob;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.jpeg'),
                radius: 16,
              ),
              const SizedBox(width: AppSize.s8),
              Text(
                appliedJob.createdBy ?? "",
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
                  SizedBox(width: AppSize.s4),
                  Text(
                    humanizeDate(DateTime.parse(appliedJob.createdAt!)),
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
            appliedJob.description ?? "",
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            appliedJob.service ?? "",
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s20),
          Text(
            'MEET UP LOCATION: ${appliedJob.location}',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s12),
          Row(
            children: [
              DefaultButton(
                onPressed: () {},
                title:
                    '${DateFormat.yMEd().format(DateTime.parse(appliedJob.startDate!))}  - ${DateFormat.yMEd().format(DateTime.parse(appliedJob.endDate!))}',
                leadingIcon: const Icon(Icons.calendar_month_rounded),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultButton(
                onPressed: () {},
                title: 'Applied',
                trailingIcon: Icons.check,
                trailingIconColor: ColorManager.kSecondaryColor,
                buttonType: ButtonType.outline,
                paddingHeight: 12,
                paddingWidth: 4,
                borderRadius: 4,
              ),
              const SizedBox(width: AppSize.s8),
              if (!appliedJob.accepted! && !appliedJob.rejected!)
                Text(
                  'Awaiting response...',
                  style: getRegularStyle(
                    color: ColorManager.kPrimary200Color,
                  ),
                ),
              if (appliedJob.accepted! || appliedJob.rejected!)
                Text(
                  appliedJob.accepted! ? 'Accepted' : 'Rejected',
                  style: getRegularStyle(
                    color: ColorManager.kPrimaryColor,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.review,
  }) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.reviewerDisplayName ?? '',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          const SizedBox(height: AppSize.s4),
          SvgPicture.asset(
            'assets/images/rating.svg',
          ),
          const SizedBox(height: AppPadding.p8),
          Text(
            review.detail ?? "",
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}
