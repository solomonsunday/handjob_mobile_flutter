// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String TitleValueKey = 'title';
const String DescriptionValueKey = 'description';
const String RatingValueKey = 'rating';

final Map<String, String> RatingValueToTitleMap = {
  '1.0': '1.0',
  '2.0': '2.0',
  '3.0': '3.0',
  '4.0': '4.0',
  '5.0': '5.0',
};

final Map<String, TextEditingController> _RateReviewViewTextEditingControllers =
    {};

final Map<String, FocusNode> _RateReviewViewFocusNodes = {};

final Map<String, String? Function(String?)?> _RateReviewViewTextValidations = {
  NameValueKey: null,
  TitleValueKey: null,
  DescriptionValueKey: null,
};

mixin $RateReviewView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get titleController =>
      _getFormTextEditingController(TitleValueKey);
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get titleFocusNode => _getFormFocusNode(TitleValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_RateReviewViewTextEditingControllers.containsKey(key)) {
      return _RateReviewViewTextEditingControllers[key]!;
    }

    _RateReviewViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _RateReviewViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_RateReviewViewFocusNodes.containsKey(key)) {
      return _RateReviewViewFocusNodes[key]!;
    }
    _RateReviewViewFocusNodes[key] = FocusNode();
    return _RateReviewViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    titleController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    titleController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));
  }

  static const bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          TitleValueKey: titleController.text,
          DescriptionValueKey: descriptionController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _RateReviewViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _RateReviewViewFocusNodes.values) {
      focusNode.dispose();
    }

    _RateReviewViewTextEditingControllers.clear();
    _RateReviewViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get titleValue => this.formValueMap[TitleValueKey] as String?;
  String? get descriptionValue =>
      this.formValueMap[DescriptionValueKey] as String?;
  String? get ratingValue => this.formValueMap[RatingValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          NameValueKey: value,
        }),
    );

    if (_RateReviewViewTextEditingControllers.containsKey(NameValueKey)) {
      _RateReviewViewTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  set titleValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          TitleValueKey: value,
        }),
    );

    if (_RateReviewViewTextEditingControllers.containsKey(TitleValueKey)) {
      _RateReviewViewTextEditingControllers[TitleValueKey]?.text = value ?? '';
    }
  }

  set descriptionValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          DescriptionValueKey: value,
        }),
    );

    if (_RateReviewViewTextEditingControllers.containsKey(
        DescriptionValueKey)) {
      _RateReviewViewTextEditingControllers[DescriptionValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasTitle =>
      this.formValueMap.containsKey(TitleValueKey) &&
      (titleValue?.isNotEmpty ?? false);
  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);
  bool get hasRating => this.formValueMap.containsKey(RatingValueKey);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasTitleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey]?.isNotEmpty ?? false;
  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;
  bool get hasRatingValidationMessage =>
      this.fieldsValidationMessages[RatingValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get titleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey];
  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
  String? get ratingValidationMessage =>
      this.fieldsValidationMessages[RatingValueKey];
}

extension Methods on FormViewModel {
  void setRating(String rating) {
    this.setData(this.formValueMap..addAll({RatingValueKey: rating}));
  }

  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TitleValueKey] = validationMessage;
  setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;
  setRatingValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RatingValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    titleValue = '';
    descriptionValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      TitleValueKey: getValidationMessage(TitleValueKey),
      DescriptionValueKey: getValidationMessage(DescriptionValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _RateReviewViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _RateReviewViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      TitleValueKey: getValidationMessage(TitleValueKey),
      DescriptionValueKey: getValidationMessage(DescriptionValueKey),
    });
