import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/services/experience.service.dart';
import 'package:handjob_mobile/sheets/profile_contact/profile_contact.sheet.dart';
import 'package:handjob_mobile/sheets/profile_experience/profile_experience.sheet.form.dart';
import 'package:handjob_mobile/utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';
import 'package:uuid/uuid.dart';

import '../../app/app.locator.dart';
import '../../models/experience.model.dart';
import '../../models/profession_type.model.dart';
import '../../models/suggestion.model.dart';
import '../../services/authentication.service.dart';
import '../../services/location.service.dart';
import '../../services/shared.service.dart';
import '../../utils/contants.dart';
import '../../utils/http_exception.dart';

@FormView(fields: [
  FormTextField(name: 'jobTitle'),
  FormTextField(name: 'company'),
  FormTextField(name: 'startDate'),
  FormTextField(name: 'endDate'),
  FormTextField(name: 'jobCategoryName'),
  FormTextField(name: 'location'),
  FormTextField(name: 'description'),
])
class ProfileExperienceSheet extends StatelessWidget
    with $ProfileExperienceSheet {
  ProfileExperienceSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  static String _displayStringForOption(Suggestion option) =>
      option.description;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileExperienceSheetViewModel>.reactive(
        viewModelBuilder: () => ProfileExperienceSheetViewModel(),
        onModelReady: (model) {
          listenToFormUpdated(model);
          //

          if (request?.data != null) {
            Experience experience = request?.data as Experience;

            jobTitleController.text = experience.jobTitle ?? "";
            companyController.text = experience.company ?? "";
            startDateController.text =
                DateFormat.yMMMd().format(experience.startDate!);
            endDateController.text = experience.endDate == null
                ? ""
                : DateFormat.yMMMd().format(experience.endDate!);
            jobCategoryNameController.text = experience.jobCategoryName ?? "";
            locationController.text = experience.location ?? "";
            descriptionController.text = experience.description ?? "";
            model.updateCurrent(experience.current ?? false);
          }
        },
        onDispose: (_) => disposeForm(),
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
                      Text('Experience'),
                    ],
                  ),
                  SizedBox(height: AppSize.s24),
                  InputField(
                    label: "Job title",
                    hintText: 'Enter job title',
                    fillColor: ColorManager.kWhiteColor,
                    controller: jobTitleController,
                  ),
                  SizedBox(height: AppSize.s12),
                  InputField(
                    label: 'Business name', //please change to company
                    hintText: 'Enter business name',
                    fillColor: ColorManager.kWhiteColor,
                    controller: companyController,
                  ),
                  SizedBox(height: AppSize.s12),
                  Row(
                    children: [
                      Expanded(
                        child: DatePicker(
                          onSelected: (p0) {},
                          label: 'Start date',
                          hintText: 'Select',
                          controller: startDateController,
                        ),
                      ),
                      if (!model.current) const SizedBox(width: AppSize.s12),
                      if (!model.current)
                        Expanded(
                          child: DatePicker(
                            onSelected: (p0) {},
                            label: 'End date',
                            hintText: 'Select',
                            controller: endDateController,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: AppSize.s12),
                  // InputField(
                  //   label: 'Job category',
                  //   hintText: 'Enter',
                  //   fillColor: ColorManager.kWhiteColor,
                  //   controller: jobCategoryNameController,
                  // ),
                  GenericDropDownField<ProfessionType>(
                    label: 'Job category',
                    hint: 'choose category',
                    value: model.selectedProfession,
                    dropdownItems: model.professions ?? [],
                    onChanged: model.handleSelectedProfession,
                    requiredField: true,
                    buttonDecoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ColorManager.kDarkColor,
                      ),
                      borderRadius: BorderRadius.circular(AppSize.s12),
                    ),
                    buttonWidth: MediaQuery.of(context).size.width,
                    dropdownWidth: MediaQuery.of(context).size.width,
                    buttonHeight: AppSize.s48,
                  ),
                  SizedBox(height: AppSize.s12),
                  Autocomplete<Suggestion>(
                    displayStringForOption: _displayStringForOption,
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text == '') {
                        return const Iterable<Suggestion>.empty();
                      }
                      await model.handleSuggestion(textEditingValue.text);

                      return model.suggestions.where((Suggestion option) {
                        return option.description
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (Suggestion selection) async {
                      debugPrint(
                          'You just selected ${_displayStringForOption(selection)}');
                      model.updateLocation(_displayStringForOption(selection));
                      // await model.updateCoordinate(selection.placeId);
                    },
                    fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) =>
                        InputField(
                      label: 'Service Location *',
                      controller: locationController,
                      focusnode: focusNode,
                      onTap: onFieldSubmitted,
                      fillColor: ColorManager.kWhiteColor,
                    ),
                  ),
                  SizedBox(height: AppSize.s12),
                  Textarea(
                    label: 'Describe the nature of work',
                    hintText: 'Enter',
                    fillColor: ColorManager.kWhiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    controller: descriptionController,
                  ),
                  SizedBox(height: AppSize.s12),
                  DefaultCheckBox(
                    value: model.current,
                    onChanged: (value) => model.updateCurrent(value),
                    richText: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Set as current',
                        style: getRegularStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s24),
                  DefaultButton(
                    onPressed: () => model.createExperience(completer),
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

class ProfileExperienceSheetViewModel extends FormViewModel {
  final _locationService = locator<LocationService>(param1: const Uuid().v4());
  final _experienceService = locator<ExperienceService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();
  final _dialogService = locator<DialogService>();

  bool _current = false;
  bool get current => _current;

  List<Suggestion> _suggestions = [];
  List<Suggestion> get suggestions => _suggestions;

  ProfessionType? _selectedProfession;
  ProfessionType? get selectedProfession => _selectedProfession;

  List<ProfessionType>? get professionTypes => _sharedService.professionTypes;
  List<ProfessionType>? get professions => professionTypes;

  void handleSelectedProfession(ProfessionType? value) {
    _selectedProfession = value;

    notifyListeners();
  }

  createExperience(completer) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want update this experience?",
    );
    if (!response!.confirmed) return;
    runBusyFuture(createExperienceRequest(completer));
  }

  createExperienceRequest(completer) async {
    print('experience json: ${selectedProfession?.toJson()}');
    var formData = {
      "jobTitle": jobTitleValue,
      "startDate": dateToIso8601String(startDateValue!),
      "endDate": current
          ? DateTime.now().toIso8601String()
          : endDateValue == null
              ? null
              : dateToIso8601String(endDateValue!),
      "current": current,
      "location": locationValue,
      "company": companyValue,
      "description": descriptionValue,
      "jobCategoryName": selectedProfession?.name,
      "jobCategoryId": selectedProfession?.id.toString(),
    };
    print('form Data: $formData');

    setBusy(true);
    try {
      await _experienceService.createExperience(formData);
      await _authenticationService.getCurrentBaseUser();
      completer!(SheetResponse(confirmed: true));
    } on DioError catch (error) {
      print('eror: ${error.response!.data}');
      _dialogService.showDialog(
        title: "An error occured",
        description: error.response?.data['message'],
      );
      // throw HttpException("An error occured");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> handleSuggestion(String text) async => runBusyFuture(
        fetchSuggestionRequest(text),
        busyObject: LOCATION_SUGGESTION_REQUEST,
      );

  Future<List<Suggestion>> fetchSuggestionRequest(String text) async {
    notifyListeners();
    setBusyForObject(LOCATION_SUGGESTION_REQUEST, true);

    try {
      _suggestions = await _locationService.fetchSuggestions(text, 'en');
      print(
          'json suggestions: ${_suggestions.map((e) => e.toJson()).toList()}');
      return _suggestions;
    } on DioError catch (e) {
      throw HttpException(e.response!.data);
    } finally {
      notifyListeners();
      setBusyForObject(LOCATION_SUGGESTION_REQUEST, false);
    }
  }

  void updateLocation(String location) {
    // locationController.text = location;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  updateCurrent(bool value) {
    _current = value;
    notifyListeners();
  }
}
