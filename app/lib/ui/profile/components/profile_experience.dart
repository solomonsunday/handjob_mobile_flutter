import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class ProfileExperience extends ViewModelWidget<ProfileViewModel> {
  const ProfileExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ProfileActionHeader(
            icon: Icons.star_border,
            title: 'Experience',
            onTap: () => model.showExperienceSheet(null),
          ),
          const SizedBox(height: AppSize.s8),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (model.currentUser!.experiences ?? [])
                  .map(
                    (experience) => ListTile(
                      minVerticalPadding: AppSize.s12,
                      contentPadding: EdgeInsets.zero,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: experience.jobTitle,
                              children: [
                                TextSpan(
                                  text: ' at ',
                                  style: getRegularStyle(
                                    color: ColorManager.kDarkColor,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                TextSpan(text: experience.company),
                              ],
                              style: getBoldStyle(
                                color: ColorManager.kDarkColor,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                          Text(
                            '(${DateFormat.yMd().format(experience.startDate!)}  -  ${experience.current == true ? 'Present' : DateFormat.yMd().format(experience.endDate!)})',
                            style: getRegularStyle(
                              color: ColorManager.kGrey,
                            ),
                          ),
                          const SizedBox(height: AppSize.s12)
                        ],
                      ),
                      subtitle: Text(
                        '${experience.description}',
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      trailing: SizedBox(
                        width: AppSize.s56,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => model.editExperience(experience),
                              child: Icon(
                                Icons.edit_outlined,
                                color: ColorManager.kDarkColor,
                                size: AppSize.s24,
                              ),
                            ),
                            SizedBox(width: AppSize.s4),
                            GestureDetector(
                              onTap: () =>
                                  model.deleteExperience(experience.id),
                              child: model.busy(DELETE_EXPERIENCE)
                                  ? const SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: ColorManager.kDarkColor,
                                      size: AppSize.s24,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),

          // ListTile(
          //   minVerticalPadding: AppSize.s12,
          //   contentPadding: EdgeInsets.zero,
          //   title: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       RichText(
          //         text: TextSpan(
          //           text: 'Inverter repair ',
          //           children: [
          //             TextSpan(
          //               text: 'at ',
          //               style: getRegularStyle(
          //                 color: ColorManager.kDarkColor,
          //                 fontSize: FontSize.s12,
          //               ),
          //             ),
          //             TextSpan(text: 'John electricals'),
          //           ],
          //           style: getBoldStyle(
          //             color: ColorManager.kDarkColor,
          //             fontSize: FontSize.s12,
          //           ),
          //         ),
          //       ),
          //       Text(
          //         '(2022/09/01  -  2022/12/21)',
          //         style: getRegularStyle(
          //           color: ColorManager.kGrey,
          //         ),
          //       ),
          //       const SizedBox(height: AppSize.s12)
          //     ],
          //   ),
          //   subtitle: Text(
          //     'Repaired an inverter by replacing the damaged fan',
          //     style: getRegularStyle(
          //       color: ColorManager.kDarkColor,
          //       fontSize: FontSize.s12,
          //     ),
          //   ),
          //   trailing: SizedBox(
          //     width: AppSize.s56,
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.edit_outlined,
          //           color: ColorManager.kDarkColor,
          //           size: AppSize.s24,
          //         ),
          //         SizedBox(width: AppSize.s4),
          //         Icon(
          //           Icons.close,
          //           color: ColorManager.kDarkColor,
          //           size: AppSize.s24,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
