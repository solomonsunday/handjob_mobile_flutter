import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/sheets/profile_education/profile_education.sheet.form.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../app/app.locator.dart';
import '../../models/education.model.dart';
import '../../services/authentication.service.dart';
import '../../services/education.service.dart';
import '../../utils/http_exception.dart';

@FormView(fields: [
  FormTextField(name: 'course'),
  FormTextField(name: 'yearOfGraduation'),
  FormTextField(name: 'institution'),
  FormTextField(name: 'city'),
  FormTextField(name: 'address')
])
class ProfileEducationSheet extends StatelessWidget
    with $ProfileEducationSheet {
  ProfileEducationSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEducationSheetViewModel>.reactive(
        viewModelBuilder: () => ProfileEducationSheetViewModel(),
        onModelReady: (model) {
          listenToFormUpdated(model);

          if (request?.data != null) {
            Education education = request?.data as Education;

            courseController.text = education.course ?? "";
            yearOfGraduationController.text =
                DateFormat.yMMMd().format(education.yearOfGraduation!);
            institutionController.text = education.institution ?? "";
            cityController.text = education.city ?? "";
            addressController.text = education.address ?? "";
            model.updateCountry(education.country ?? "");
            model.updateQualification(education.qualification ?? "");
          }
        },
        onDispose: (model) => disposeForm(),
        builder: (context, model, child) {
          return BottomSheetContainer(
            onClose: () => completer!(SheetResponse(confirmed: false)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.tag,
                      color: ColorManager.kSecondaryColor,
                    ),
                    SizedBox(width: AppSize.s12),
                    Text('Education'),
                  ],
                ),
                SizedBox(height: AppSize.s24),
                DefaultDropDownField(
                  label: "Qualifications",
                  hint: 'Enter qualification',
                  dropdownItems: model.qualifications,
                  onChanged: (value) => model.updateQualification(value!),
                  value: model.qualification,
                ),
                SizedBox(height: AppSize.s12),
                InputField(
                  label: 'Course',
                  hintText: 'Enter course name',
                  fillColor: ColorManager.kWhiteColor,
                  controller: courseController,
                  focusnode: courseFocusNode,
                ),
                SizedBox(height: AppSize.s12),
                InputField(
                  label: 'Year of graduation',
                  hintText: 'Enter ',
                  fillColor: ColorManager.kWhiteColor,
                  controller: yearOfGraduationController,
                  focusnode: yearOfGraduationFocusNode,
                ),
                SizedBox(height: AppSize.s12),
                InputField(
                  label: 'Institution name',
                  hintText: 'Enter ',
                  fillColor: ColorManager.kWhiteColor,
                  controller: institutionController,
                  focusnode: institutionFocusNode,
                ),
                SizedBox(height: AppSize.s12),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        label: 'City',
                        hintText: 'Enter',
                        controller: cityController,
                        focusnode: cityFocusNode,
                      ),
                    ),
                    SizedBox(width: AppSize.s12),
                    Expanded(
                      child: DefaultDropDownField(
                        dropdownItems: model.countries,
                        value: model.country,
                        hint: 'Country',
                        onChanged: (value) => model.updateCountry(value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s12),
                Textarea(
                  label: 'Address',
                  hintText: 'Enter',
                  fillColor: ColorManager.kWhiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  controller: addressController,
                  focusnode: addressFocusNode,
                ),
                const SizedBox(height: AppSize.s24),
                DefaultButton(
                  onPressed: () {
                    model.createEducation(completer);
                  },
                  title: 'Save changes',
                  busy: model.isBusy,
                  disabled: model.isBusy,
                )
              ],
            ),
          );
        });
  }
}

class ProfileEducationSheetViewModel extends FormViewModel {
  final _educationService = locator<EducationService>();
  final _authenticationService = locator<AuthenticationService>();

  List<String> _countries = [];
  List<String> get countries => _countries;

  List<String> _qualifications = ["OND", "HND", "B.Sc", "M.BA", "M.Sc", "PhD"];
  List<String> get qualifications => _qualifications;

  createEducation(completer) async {
    runBusyFuture(createEducationRequest(completer));
  }

  createEducationRequest(completer) async {
    var formData = {
      "institution": institutionValue,
      "qualification": qualification,
      "course": courseValue,
      "yearOfGraduation": dateToIso8601String(yearOfGraduationValue!),
      "address": addressValue,
      "city": cityValue,
      "country": country
    };
    print('form Data: $formData');

    setBusy(true);
    try {
      await _educationService.createEducation(formData);
      await _authenticationService.getCurrentBaseUser();
      completer!(SheetResponse(confirmed: true));
    } on DioError catch (error) {
      print('eror: ${error.response!.data}');
      throw HttpException("An error occured");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void updateLocation(String location) {
    // locationController.text = location;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  String? _country;
  String? get country => _country;
  String? _qualification;
  String? get qualification => _qualification;

  updateCountry(String value) {
    _country = value;
    notifyListeners();
  }

  updateQualification(String value) {
    _qualification = value;
    notifyListeners();
  }
}
