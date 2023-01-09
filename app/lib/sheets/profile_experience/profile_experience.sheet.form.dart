// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String JobTitleValueKey = 'jobTitle';
const String CompanyValueKey = 'company';
const String StartDateValueKey = 'startDate';
const String EndDateValueKey = 'endDate';
const String JobCategoryNameValueKey = 'jobCategoryName';
const String LocationValueKey = 'location';
const String DescriptionValueKey = 'description';

final Map<String, TextEditingController>
    _ProfileExperienceSheetTextEditingControllers = {};

final Map<String, FocusNode> _ProfileExperienceSheetFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ProfileExperienceSheetTextValidations = {
  JobTitleValueKey: null,
  CompanyValueKey: null,
  StartDateValueKey: null,
  EndDateValueKey: null,
  JobCategoryNameValueKey: null,
  LocationValueKey: null,
  DescriptionValueKey: null,
};

mixin $ProfileExperienceSheet on StatelessWidget {
  TextEditingController get jobTitleController =>
      _getFormTextEditingController(JobTitleValueKey);
  TextEditingController get companyController =>
      _getFormTextEditingController(CompanyValueKey);
  TextEditingController get startDateController =>
      _getFormTextEditingController(StartDateValueKey);
  TextEditingController get endDateController =>
      _getFormTextEditingController(EndDateValueKey);
  TextEditingController get jobCategoryNameController =>
      _getFormTextEditingController(JobCategoryNameValueKey);
  TextEditingController get locationController =>
      _getFormTextEditingController(LocationValueKey);
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);
  FocusNode get jobTitleFocusNode => _getFormFocusNode(JobTitleValueKey);
  FocusNode get companyFocusNode => _getFormFocusNode(CompanyValueKey);
  FocusNode get startDateFocusNode => _getFormFocusNode(StartDateValueKey);
  FocusNode get endDateFocusNode => _getFormFocusNode(EndDateValueKey);
  FocusNode get jobCategoryNameFocusNode =>
      _getFormFocusNode(JobCategoryNameValueKey);
  FocusNode get locationFocusNode => _getFormFocusNode(LocationValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ProfileExperienceSheetTextEditingControllers.containsKey(key)) {
      return _ProfileExperienceSheetTextEditingControllers[key]!;
    }
    _ProfileExperienceSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ProfileExperienceSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ProfileExperienceSheetFocusNodes.containsKey(key)) {
      return _ProfileExperienceSheetFocusNodes[key]!;
    }
    _ProfileExperienceSheetFocusNodes[key] = FocusNode();
    return _ProfileExperienceSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    jobTitleController.addListener(() => _updateFormData(model));
    companyController.addListener(() => _updateFormData(model));
    startDateController.addListener(() => _updateFormData(model));
    endDateController.addListener(() => _updateFormData(model));
    jobCategoryNameController.addListener(() => _updateFormData(model));
    locationController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          JobTitleValueKey: jobTitleController.text,
          CompanyValueKey: companyController.text,
          StartDateValueKey: startDateController.text,
          EndDateValueKey: endDateController.text,
          JobCategoryNameValueKey: jobCategoryNameController.text,
          LocationValueKey: locationController.text,
          DescriptionValueKey: descriptionController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        JobTitleValueKey: _getValidationMessage(JobTitleValueKey),
        CompanyValueKey: _getValidationMessage(CompanyValueKey),
        StartDateValueKey: _getValidationMessage(StartDateValueKey),
        EndDateValueKey: _getValidationMessage(EndDateValueKey),
        JobCategoryNameValueKey: _getValidationMessage(JobCategoryNameValueKey),
        LocationValueKey: _getValidationMessage(LocationValueKey),
        DescriptionValueKey: _getValidationMessage(DescriptionValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ProfileExperienceSheetTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _ProfileExperienceSheetTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _ProfileExperienceSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ProfileExperienceSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _ProfileExperienceSheetTextEditingControllers.clear();
    _ProfileExperienceSheetFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get jobTitleValue => this.formValueMap[JobTitleValueKey] as String?;
  String? get companyValue => this.formValueMap[CompanyValueKey] as String?;
  String? get startDateValue => this.formValueMap[StartDateValueKey] as String?;
  String? get endDateValue => this.formValueMap[EndDateValueKey] as String?;
  String? get jobCategoryNameValue =>
      this.formValueMap[JobCategoryNameValueKey] as String?;
  String? get locationValue => this.formValueMap[LocationValueKey] as String?;
  String? get descriptionValue =>
      this.formValueMap[DescriptionValueKey] as String?;

  bool get hasJobTitle =>
      this.formValueMap.containsKey(JobTitleValueKey) &&
      (jobTitleValue?.isNotEmpty ?? false);
  bool get hasCompany =>
      this.formValueMap.containsKey(CompanyValueKey) &&
      (companyValue?.isNotEmpty ?? false);
  bool get hasStartDate =>
      this.formValueMap.containsKey(StartDateValueKey) &&
      (startDateValue?.isNotEmpty ?? false);
  bool get hasEndDate =>
      this.formValueMap.containsKey(EndDateValueKey) &&
      (endDateValue?.isNotEmpty ?? false);
  bool get hasJobCategoryName =>
      this.formValueMap.containsKey(JobCategoryNameValueKey) &&
      (jobCategoryNameValue?.isNotEmpty ?? false);
  bool get hasLocation =>
      this.formValueMap.containsKey(LocationValueKey) &&
      (locationValue?.isNotEmpty ?? false);
  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);

  bool get hasJobTitleValidationMessage =>
      this.fieldsValidationMessages[JobTitleValueKey]?.isNotEmpty ?? false;
  bool get hasCompanyValidationMessage =>
      this.fieldsValidationMessages[CompanyValueKey]?.isNotEmpty ?? false;
  bool get hasStartDateValidationMessage =>
      this.fieldsValidationMessages[StartDateValueKey]?.isNotEmpty ?? false;
  bool get hasEndDateValidationMessage =>
      this.fieldsValidationMessages[EndDateValueKey]?.isNotEmpty ?? false;
  bool get hasJobCategoryNameValidationMessage =>
      this.fieldsValidationMessages[JobCategoryNameValueKey]?.isNotEmpty ??
      false;
  bool get hasLocationValidationMessage =>
      this.fieldsValidationMessages[LocationValueKey]?.isNotEmpty ?? false;
  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;

  String? get jobTitleValidationMessage =>
      this.fieldsValidationMessages[JobTitleValueKey];
  String? get companyValidationMessage =>
      this.fieldsValidationMessages[CompanyValueKey];
  String? get startDateValidationMessage =>
      this.fieldsValidationMessages[StartDateValueKey];
  String? get endDateValidationMessage =>
      this.fieldsValidationMessages[EndDateValueKey];
  String? get jobCategoryNameValidationMessage =>
      this.fieldsValidationMessages[JobCategoryNameValueKey];
  String? get locationValidationMessage =>
      this.fieldsValidationMessages[LocationValueKey];
  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
}

extension Methods on FormViewModel {
  setJobTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[JobTitleValueKey] = validationMessage;
  setCompanyValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CompanyValueKey] = validationMessage;
  setStartDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StartDateValueKey] = validationMessage;
  setEndDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EndDateValueKey] = validationMessage;
  setJobCategoryNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[JobCategoryNameValueKey] =
          validationMessage;
  setLocationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LocationValueKey] = validationMessage;
  setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;
}
