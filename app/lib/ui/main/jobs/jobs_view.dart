import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/jobs/jobs_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/components/home_card.dart';
import 'package:ui_package/ui_package.dart';

import '../../../models/instant_job.model.dart';

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
              leadingIcon: Icon(
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s12,
                      vertical: AppSize.s12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: InputField(
                      hintText: 'Search',
                      paddingBottom: AppPadding.p8,
                      paddingTop: AppPadding.p8,
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorManager.kGrey3,
                      ),
                      onChanged: model.handleSearch,
                    ),
                  ),
                  SizedBox(height: AppSize.s8),
                  if (model.isBusy)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.jobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        InstantJob instantJob = model.jobs[index];
                        return JobItem(instantJob: instantJob);
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
  const JobItem({Key? key, required this.instantJob}) : super(key: key);

  final InstantJob instantJob;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://xsgames.co/randomusers/avatar.php?g=male'),
                  ),
                ),
              ),
              SizedBox(width: AppSize.s8),
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
            '${instantJob.description}',
            style: getBoldStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            '${instantJob.service}',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s20),
          Text(
            'MEET UP LOCATION: ${instantJob.meetupLocation}',
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
                title: 'Today',
                leadingIcon: Icons.calendar_month_rounded,
                leadingIconColor: ColorManager.kSecondaryColor,
                buttonType: ButtonType.outline,
                paddingHeight: 12,
                paddingWidth: 4,
                borderRadius: 4,
              ),
              SizedBox(width: AppSize.s4),
              DefaultButton(
                onPressed: () {},
                title: 'Alimosho',
                leadingIcon: Icons.pin_drop_outlined,
                leadingIconColor: ColorManager.kSecondaryColor,
                buttonType: ButtonType.outline,
                paddingHeight: 12,
                paddingWidth: 4,
                borderRadius: 4,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefaultButton(
                onPressed: () {},
                title: 'Apply',
                buttonType: ButtonType.fill,
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
    );
  }
}
