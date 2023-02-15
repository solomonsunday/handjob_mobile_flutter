import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/services/education.service.dart';
import 'package:handjob_mobile/ui/profile/profile_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../app/app.locator.dart';
import '../../../../enums/bottom_sheet_type.dart';
import '../../../../models/education.model.dart';
import '../../../../models/user.model.dart';
import '../../../../services/authentication.service.dart';
import '../../../../utils/http_exception.dart';

class ProfileEducationApprenticeship extends StatelessWidget {
  const ProfileEducationApprenticeship({
    Key? key,
    required this.currentUser,
    this.showEducationApprenticeSheet,
    this.isView = false,
  }) : super(key: key);

  final User? currentUser;
  final VoidCallback? showEducationApprenticeSheet;
  final bool isView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ProfileActionHeader(
            icon: Icons.menu_book_rounded,
            title: 'Education/ Apprenticeship',
            onTap: showEducationApprenticeSheet,
          ),
          const SizedBox(height: AppSize.s8),
          if ((currentUser?.educations ?? []).isEmpty)
            Text(
              'No education added',
              style: getRegularStyle(
                color: ColorManager.kGrey,
                fontSize: FontSize.s12,
              ),
            ),
          if ((currentUser?.educations ?? []).isEmpty)
            const SizedBox(height: AppSize.s8),
          if ((currentUser?.educations ?? []).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (currentUser?.educations ?? [])
                  .map(
                    (education) => ProfileEducationItem(
                      education: education,
                      isView: isView,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class ProfileEducationItem extends StatelessWidget {
  const ProfileEducationItem({
    super.key,
    required this.education,
    this.isView = false,
  });

  final Education education;
  final bool isView;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEducationItemViewModel>.reactive(
        viewModelBuilder: () => ProfileEducationItemViewModel(),
        builder: (context, model, child) {
          return ListTile(
            minVerticalPadding: AppSize.s12,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: education.qualification,
                    children: [
                      TextSpan(
                        text: ' in ',
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      TextSpan(text: education.course),
                    ],
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
                Text(
                  'Graduation (${DateFormat.yMd().format(education.yearOfGraduation!)})',
                  style: getRegularStyle(
                    color: ColorManager.kGrey,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${education.institution}',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
                Text(
                  '${education.city}, ${education.country}',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ],
            ),
            trailing: isView
                ? const SizedBox(width: AppSize.s56)
                : SizedBox(
                    width: AppSize.s56,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => model.editEducation(education),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: ColorManager.kDarkColor,
                            size: AppSize.s24,
                          ),
                        ),
                        const SizedBox(width: AppSize.s4),
                        GestureDetector(
                          onTap: () => model.deleteEducation(education.id),
                          child: model.busy(DELETE_EDUCATION)
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

const String DELETE_EDUCATION = "DELETE_EDUCATION";

class ProfileEducationItemViewModel extends BaseViewModel {
  final _educationService = locator<EducationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();

  showEducationApprenticeSheet(Education? data) =>
      _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.profile_education,
        data: data,
        isScrollControlled: true,
        ignoreSafeArea: true,
        enterBottomSheetDuration: Duration(milliseconds: 400),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        enableDrag: true,
      );

  editEducation(Education education) {
    showEducationApprenticeSheet(education);
  }

  ///Experience
  Future<void> deleteEducation(String? id) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want delete this education?",
    );
    if (!response!.confirmed) return;

    setBusyForObject(DELETE_EDUCATION, true);
    try {
      await _educationService.deleteEducation(id!);
      await _authenticationService.getCurrentBaseUser();
    } on DioError catch (error) {
      throw HttpException("An error occured");
    } finally {
      setBusyForObject(DELETE_EDUCATION, false);
    }
  }
}
