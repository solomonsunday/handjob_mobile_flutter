import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/qualification.model.dart';
import 'package:handjob_mobile/services/shared.service.dart';
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
        onModelReady: (model) async {
          listenToFormUpdated(model);
          print('countires: ${model.countries}');
          print('qualification: ${model.qualification}');
          if (model.qualifications.isEmpty) {
            await model.fetchQualification();
            print('qualification: ${model.qualification}');
          }
          if (request?.data != null) {
            Education education = request?.data as Education;
            print('education params: ${education.toJson()}');
            courseController.text = education.course ?? "";
            yearOfGraduationController.text = fromIsoToDateTimeToDefaultFormat(
                education.yearOfGraduation!, DEFAULT_DATE_TIME_FORMAT);
            institutionController.text = education.institution ?? "";
            cityController.text = education.city ?? "";
            addressController.text = education.address ?? "";
            model.updateCountry(education.country);

            for (Qualification element in model.qualifications) {
              if (element.name.toLowerCase() ==
                  education.qualification?.toLowerCase()) {
                model.updateQualification(element);
                break;
              }

              model.updateQualification(null);
            }

            model.updateId(education.id);
            model.updateEditMode(true);
          }
        },
        onDispose: (model) => disposeForm(),
        builder: (context, model, child) {
          return BottomSheetContainer(
            onClose: () => completer!(SheetResponse(confirmed: false)),
            child: SingleChildScrollView(
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
                  GenericDropDownField<Qualification>(
                    label: "Qualifications",
                    hint: 'Enter qualification',
                    dropdownItems: model.qualifications,
                    onChanged: (value) => model.updateQualification(value!),
                    value: model.qualification,
                    buttonHeight: 50,
                    buttonWidth: MediaQuery.of(context).size.width,
                    buttonDecoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ColorManager.kDarkColor,
                      ),
                      borderRadius: BorderRadius.circular(AppSize.s8),
                    ),
                    dropdownWidth: MediaQuery.of(context).size.width,
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
                  DatePicker(
                    label: 'Year of graduation',
                    hintText: 'Enter ',
                    controller: yearOfGraduationController,
                    onSelected: (p0) {},
                    dateFormat: DEFAULT_DATE_TIME_FORMAT,
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
                          label: "Country",
                          dropdownItems: model.countries,
                          value: model.country,
                          hint: 'Country',
                          onChanged: (value) => model.updateCountry(value!),
                          buttonHeight: 50,
                          buttonWidth: MediaQuery.of(context).size.width,
                          buttonDecoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorManager.kDarkColor,
                            ),
                            borderRadius: BorderRadius.circular(AppSize.s8),
                          ),
                          dropdownWidth: MediaQuery.of(context).size.width,
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
                      if (model.editMode) {
                        model.updateEducation(completer);
                      } else {
                        model.createEducation(completer);
                      }
                    },
                    title: 'Save changes',
                    busy: model.isBusy,
                    disabled: model.isBusy,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class ProfileEducationSheetViewModel extends FormViewModel {
  final _educationService = locator<EducationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();
  final _dialogService = locator<DialogService>();

  bool _editMode = false;
  bool get editMode => _editMode;

  List<String> get countries =>
      (_sharedService.countries ?? []).map((e) => e.name!).toList();

  List<Qualification> get qualifications => _sharedService.qualifications ?? [];

  createEducation(completer) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want create education?",
    );
    if (!response!.confirmed) return;
    runBusyFuture(createEducationRequest(completer));
  }

  updateEducation(completer) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want update education?",
    );
    if (!response!.confirmed) return;
    runBusyFuture(updateEducationRequest(completer));
  }

  createEducationRequest(completer) async {
    print('CREATE MODE');
    var formData = {
      "institution": institutionValue,
      "qualification": qualification?.name,
      "course": courseValue,
      "yearOfGraduation": dateToIso8601String(yearOfGraduationValue!,
          dtFormat: DEFAULT_DATE_TIME_FORMAT),
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
      _dialogService.showDialog(
        title: "An error occured",
        description: error.response?.data['message'],
      );
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  updateEducationRequest(completer) async {
    print('update MODE');
    var formData = {
      "institution": institutionValue,
      "qualification": qualification?.name,
      "course": courseValue,
      "yearOfGraduation": dateToIso8601String(yearOfGraduationValue!,
          dtFormat: DEFAULT_DATE_TIME_FORMAT),
      "address": addressValue,
      "city": cityValue,
      "country": country
    };
    print('form Data: $formData');

    setBusy(true);
    try {
      await _educationService.updateEducation(id!, formData);
      await _authenticationService.getCurrentBaseUser();
      completer!(SheetResponse(confirmed: true));
    } on DioError catch (error) {
      print('eror: ${error.response!.data}');
      _dialogService.showDialog(
        title: "An error occured",
        description: error.response?.data['message'],
      );
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

  String? _id;
  String? get id => _id;
  String? _country;
  String? get country => _country;
  Qualification? _qualification;
  Qualification? get qualification => _qualification;

  updateCountry(String? value) {
    if ((_sharedService.countries ?? [])
        .where((element) => element.name == value)
        .isNotEmpty) {
      _country = value;
    } else {
      _country = null;
    }
    notifyListeners();
  }

  updateQualification(Qualification? value) {
    _qualification = value;
    notifyListeners();
  }

  void updateEditMode(bool value) {
    _editMode = value;
    notifyListeners();
  }

  void updateId(String? id) {
    _id = id;
  }

  Future<void> fetchQualification() async {
    try {
      await _sharedService.getQualification();
      print('fetch qualifications');
    } catch (e) {}
  }
}
