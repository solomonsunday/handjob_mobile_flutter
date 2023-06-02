// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String EmailValueKey = 'email';

final Map<String, TextEditingController>
    _ForgotPasswordViewTextEditingControllers = {};

final Map<String, FocusNode> _ForgotPasswordViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ForgotPasswordViewTextValidations = {
  EmailValueKey: null,
};

mixin $ForgotPasswordView {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ForgotPasswordViewTextEditingControllers.containsKey(key)) {
      return _ForgotPasswordViewTextEditingControllers[key]!;
    }

    _ForgotPasswordViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ForgotPasswordViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ForgotPasswordViewFocusNodes.containsKey(key)) {
      return _ForgotPasswordViewFocusNodes[key]!;
    }
    _ForgotPasswordViewFocusNodes[key] = FocusNode();
    return _ForgotPasswordViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
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
          EmailValueKey: emailController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ForgotPasswordViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ForgotPasswordViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ForgotPasswordViewTextEditingControllers.clear();
    _ForgotPasswordViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;

  set emailValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          EmailValueKey: value,
        }),
    );

    if (_ForgotPasswordViewTextEditingControllers.containsKey(EmailValueKey)) {
      _ForgotPasswordViewTextEditingControllers[EmailValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
}

extension Methods on FormViewModel {
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ForgotPasswordViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ForgotPasswordViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
