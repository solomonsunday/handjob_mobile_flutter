import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../app/app.locator.dart';
import '../../../../enums/bottom_sheet_type.dart';
import '../../../../models/experience.model.dart';
import '../../../../models/user.model.dart';
import '../../../../services/experience.service.dart';
import '../../../../utils/http_exception.dart';

class ProfileExperience extends StatelessWidget {
  const ProfileExperience({
    Key? key,
    required this.currentUser,
    this.isView = false,
    this.showExperienceSheet,
  }) : super(key: key);

  final User? currentUser;
  final bool isView;
  final VoidCallback? showExperienceSheet;

  @override
  Widget build(BuildContext context) {
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
            onTap: showExperienceSheet,
          ),
          const SizedBox(height: AppSize.s8),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (currentUser?.experiences ?? [])
                  .map(
                    (experience) => ProfileExperienceItem(
                      experience: experience,
                      isView: isView,
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}

class ProfileExperienceItem extends StatelessWidget {
  const ProfileExperienceItem({
    super.key,
    required this.experience,
    this.isView = false,
  });

  final Experience experience;
  final bool isView;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileExperienceItemViewModel>.reactive(
        viewModelBuilder: () => ProfileExperienceItemViewModel(),
        builder: (context, model, child) {
          return ListTile(
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
            trailing: isView
                ? const SizedBox(width: AppSize.s56)
                : SizedBox(
                    width: AppSize.s56,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => model.editExperience(experience),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: ColorManager.kDarkColor,
                            size: AppSize.s24,
                          ),
                        ),
                        SizedBox(width: AppSize.s4),
                        GestureDetector(
                          onTap: () => model.deleteExperience(experience.id),
                          child: model.busy(DELETE_EXPERIENCE)
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator.adaptive(),
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
          );
        });
  }
}

const String DELETE_EXPERIENCE = "DELETE_EXPERIENCE";

class ProfileExperienceItemViewModel extends BaseViewModel {
  final _experienceService = locator<ExperienceService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  showExperienceSheet(Experience? data) => _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_experience,
        data: data,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );
  editExperience(Experience experience) {
    showExperienceSheet(experience);
  }

  ///Experience
  Future<void> deleteExperience(String? id) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Do you want to delete this experience ?",
    );
    if (!response!.confirmed) return;
    setBusyForObject(DELETE_EXPERIENCE, true);
    try {
      await _experienceService.deleteExperience(id!);
    } on DioError catch (error) {
      throw HttpException("An error occured");
    } finally {
      setBusyForObject(DELETE_EXPERIENCE, false);
    }
  }
}
