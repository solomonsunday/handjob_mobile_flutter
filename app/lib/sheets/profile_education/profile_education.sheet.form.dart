// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CourseValueKey = 'course';
const String YearOfGraduationValueKey = 'yearOfGraduation';
const String InstitutionValueKey = 'institution';
const String CityValueKey = 'city';
const String AddressValueKey = 'address';

final Map<String, TextEditingController>
    _ProfileEducationSheetTextEditingControllers = {};

final Map<String, FocusNode> _ProfileEducationSheetFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ProfileEducationSheetTextValidations = {
  CourseValueKey: null,
  YearOfGraduationValueKey: null,
  InstitutionValueKey: null,
  CityValueKey: null,
  AddressValueKey: null,
};

mixin $ProfileEducationSheet on StatelessWidget {
  TextEditingController get courseController =>
      _getFormTextEditingController(CourseValueKey);
  TextEditingController get yearOfGraduationController =>
      _getFormTextEditingController(YearOfGraduationValueKey);
  TextEditingController get institutionController =>
      _getFormTextEditingController(InstitutionValueKey);
  TextEditingController get cityController =>
      _getFormTextEditingController(CityValueKey);
  TextEditingController get addressController =>
      _getFormTextEditingController(AddressValueKey);
  FocusNode get courseFocusNode => _getFormFocusNode(CourseValueKey);
  FocusNode get yearOfGraduationFocusNode =>
      _getFormFocusNode(YearOfGraduationValueKey);
  FocusNode get institutionFocusNode => _getFormFocusNode(InstitutionValueKey);
  FocusNode get cityFocusNode => _getFormFocusNode(CityValueKey);
  FocusNode get addressFocusNode => _getFormFocusNode(AddressValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ProfileEducationSheetTextEditingControllers.containsKey(key)) {
      return _ProfileEducationSheetTextEditingControllers[key]!;
    }
    _ProfileEducationSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ProfileEducationSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ProfileEducationSheetFocusNodes.containsKey(key)) {
      return _ProfileEducationSheetFocusNodes[key]!;
    }
    _ProfileEducationSheetFocusNodes[key] = FocusNode();
    return _ProfileEducationSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    courseController.addListener(() => _updateFormData(model));
    yearOfGraduationController.addListener(() => _updateFormData(model));
    institutionController.addListener(() => _updateFormData(model));
    cityController.addListener(() => _updateFormData(model));
    addressController.addListener(() => _updateFormData(model));
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
          CourseValueKey: courseController.text,
          YearOfGraduationValueKey: yearOfGraduationController.text,
          InstitutionValueKey: institutionController.text,
          CityValueKey: cityController.text,
          AddressValueKey: addressController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        CourseValueKey: _getValidationMessage(CourseValueKey),
        YearOfGraduationValueKey:
            _getValidationMessage(YearOfGraduationValueKey),
        InstitutionValueKey: _getValidationMessage(InstitutionValueKey),
        CityValueKey: _getValidationMessage(CityValueKey),
        AddressValueKey: _getValidationMessage(AddressValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ProfileEducationSheetTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _ProfileEducationSheetTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _ProfileEducationSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ProfileEducationSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _ProfileEducationSheetTextEditingControllers.clear();
    _ProfileEducationSheetFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get courseValue => this.formValueMap[CourseValueKey] as String?;
  String? get yearOfGraduationValue =>
      this.formValueMap[YearOfGraduationValueKey] as String?;
  String? get institutionValue =>
      this.formValueMap[InstitutionValueKey] as String?;
  String? get cityValue => this.formValueMap[CityValueKey] as String?;
  String? get addressValue => this.formValueMap[AddressValueKey] as String?;

  bool get hasCourse =>
      this.formValueMap.containsKey(CourseValueKey) &&
      (courseValue?.isNotEmpty ?? false);
  bool get hasYearOfGraduation =>
      this.formValueMap.containsKey(YearOfGraduationValueKey) &&
      (yearOfGraduationValue?.isNotEmpty ?? false);
  bool get hasInstitution =>
      this.formValueMap.containsKey(InstitutionValueKey) &&
      (institutionValue?.isNotEmpty ?? false);
  bool get hasCity =>
      this.formValueMap.containsKey(CityValueKey) &&
      (cityValue?.isNotEmpty ?? false);
  bool get hasAddress =>
      this.formValueMap.containsKey(AddressValueKey) &&
      (addressValue?.isNotEmpty ?? false);

  bool get hasCourseValidationMessage =>
      this.fieldsValidationMessages[CourseValueKey]?.isNotEmpty ?? false;
  bool get hasYearOfGraduationValidationMessage =>
      this.fieldsValidationMessages[YearOfGraduationValueKey]?.isNotEmpty ??
      false;
  bool get hasInstitutionValidationMessage =>
      this.fieldsValidationMessages[InstitutionValueKey]?.isNotEmpty ?? false;
  bool get hasCityValidationMessage =>
      this.fieldsValidationMessages[CityValueKey]?.isNotEmpty ?? false;
  bool get hasAddressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey]?.isNotEmpty ?? false;

  String? get courseValidationMessage =>
      this.fieldsValidationMessages[CourseValueKey];
  String? get yearOfGraduationValidationMessage =>
      this.fieldsValidationMessages[YearOfGraduationValueKey];
  String? get institutionValidationMessage =>
      this.fieldsValidationMessages[InstitutionValueKey];
  String? get cityValidationMessage =>
      this.fieldsValidationMessages[CityValueKey];
  String? get addressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey];
}

extension Methods on FormViewModel {
  setCourseValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CourseValueKey] = validationMessage;
  setYearOfGraduationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[YearOfGraduationValueKey] =
          validationMessage;
  setInstitutionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[InstitutionValueKey] = validationMessage;
  setCityValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CityValueKey] = validationMessage;
  setAddressValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressValueKey] = validationMessage;
}
