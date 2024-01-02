// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String TitleValueKey = 'title';
const String MessageValueKey = 'message';

final Map<String, TextEditingController>
    _HelpAndSupportViewTextEditingControllers = {};

final Map<String, FocusNode> _HelpAndSupportViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _HelpAndSupportViewTextValidations = {
  TitleValueKey: null,
  MessageValueKey: null,
};

mixin $HelpAndSupportView {
  TextEditingController get titleController =>
      _getFormTextEditingController(TitleValueKey);
  TextEditingController get messageController =>
      _getFormTextEditingController(MessageValueKey);
  FocusNode get titleFocusNode => _getFormFocusNode(TitleValueKey);
  FocusNode get messageFocusNode => _getFormFocusNode(MessageValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_HelpAndSupportViewTextEditingControllers.containsKey(key)) {
      return _HelpAndSupportViewTextEditingControllers[key]!;
    }

    _HelpAndSupportViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _HelpAndSupportViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_HelpAndSupportViewFocusNodes.containsKey(key)) {
      return _HelpAndSupportViewFocusNodes[key]!;
    }
    _HelpAndSupportViewFocusNodes[key] = FocusNode();
    return _HelpAndSupportViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    titleController.addListener(() => _updateFormData(model));
    messageController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    titleController.addListener(() => _updateFormData(model));
    messageController.addListener(() => _updateFormData(model));
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
          TitleValueKey: titleController.text,
          MessageValueKey: messageController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _HelpAndSupportViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _HelpAndSupportViewFocusNodes.values) {
      focusNode.dispose();
    }

    _HelpAndSupportViewTextEditingControllers.clear();
    _HelpAndSupportViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get titleValue => this.formValueMap[TitleValueKey] as String?;
  String? get messageValue => this.formValueMap[MessageValueKey] as String?;

  set titleValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          TitleValueKey: value,
        }),
    );

    if (_HelpAndSupportViewTextEditingControllers.containsKey(TitleValueKey)) {
      _HelpAndSupportViewTextEditingControllers[TitleValueKey]?.text =
          value ?? '';
    }
  }

  set messageValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          MessageValueKey: value,
        }),
    );

    if (_HelpAndSupportViewTextEditingControllers.containsKey(
        MessageValueKey)) {
      _HelpAndSupportViewTextEditingControllers[MessageValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasTitle =>
      this.formValueMap.containsKey(TitleValueKey) &&
      (titleValue?.isNotEmpty ?? false);
  bool get hasMessage =>
      this.formValueMap.containsKey(MessageValueKey) &&
      (messageValue?.isNotEmpty ?? false);

  bool get hasTitleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey]?.isNotEmpty ?? false;
  bool get hasMessageValidationMessage =>
      this.fieldsValidationMessages[MessageValueKey]?.isNotEmpty ?? false;

  String? get titleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey];
  String? get messageValidationMessage =>
      this.fieldsValidationMessages[MessageValueKey];
}

extension Methods on FormViewModel {
  setTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TitleValueKey] = validationMessage;
  setMessageValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MessageValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    titleValue = '';
    messageValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TitleValueKey: getValidationMessage(TitleValueKey),
      MessageValueKey: getValidationMessage(MessageValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _HelpAndSupportViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _HelpAndSupportViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      TitleValueKey: getValidationMessage(TitleValueKey),
      MessageValueKey: getValidationMessage(MessageValueKey),
    });
