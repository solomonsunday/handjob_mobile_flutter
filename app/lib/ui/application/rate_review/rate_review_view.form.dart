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

final Map<String, TextEditingController> _RateReviewViewTextEditingControllers =
    {};

final Map<String, FocusNode> _RateReviewViewFocusNodes = {};

final Map<String, String? Function(String?)?> _RateReviewViewTextValidations = {
  NameValueKey: null,
  TitleValueKey: null,
  DescriptionValueKey: null,
};

mixin $RateReviewView on StatelessWidget {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get titleController =>
      _getFormTextEditingController(TitleValueKey);
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get titleFocusNode => _getFormFocusNode(TitleValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
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
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    titleController.addListener(() => _updateFormData(model));
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
          NameValueKey: nameController.text,
          TitleValueKey: titleController.text,
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
        NameValueKey: _getValidationMessage(NameValueKey),
        TitleValueKey: _getValidationMessage(TitleValueKey),
        DescriptionValueKey: _getValidationMessage(DescriptionValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _RateReviewViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_RateReviewViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
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

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasTitle =>
      this.formValueMap.containsKey(TitleValueKey) &&
      (titleValue?.isNotEmpty ?? false);
  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasTitleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey]?.isNotEmpty ?? false;
  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get titleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey];
  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
}

extension Methods on FormViewModel {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TitleValueKey] = validationMessage;
  setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;
}
