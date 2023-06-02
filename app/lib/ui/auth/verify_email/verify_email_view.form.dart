// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String OtpCodeValueKey = 'otpCode';

final Map<String, TextEditingController>
    _VerifyEmailViewTextEditingControllers = {};

final Map<String, FocusNode> _VerifyEmailViewFocusNodes = {};

final Map<String, String? Function(String?)?> _VerifyEmailViewTextValidations =
    {
  OtpCodeValueKey: null,
};

mixin $VerifyEmailView {
  TextEditingController get otpCodeController =>
      _getFormTextEditingController(OtpCodeValueKey);
  FocusNode get otpCodeFocusNode => _getFormFocusNode(OtpCodeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_VerifyEmailViewTextEditingControllers.containsKey(key)) {
      return _VerifyEmailViewTextEditingControllers[key]!;
    }

    _VerifyEmailViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _VerifyEmailViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_VerifyEmailViewFocusNodes.containsKey(key)) {
      return _VerifyEmailViewFocusNodes[key]!;
    }
    _VerifyEmailViewFocusNodes[key] = FocusNode();
    return _VerifyEmailViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    otpCodeController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    otpCodeController.addListener(() => _updateFormData(model));
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
          OtpCodeValueKey: otpCodeController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _VerifyEmailViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _VerifyEmailViewFocusNodes.values) {
      focusNode.dispose();
    }

    _VerifyEmailViewTextEditingControllers.clear();
    _VerifyEmailViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get otpCodeValue => this.formValueMap[OtpCodeValueKey] as String?;

  set otpCodeValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          OtpCodeValueKey: value,
        }),
    );

    if (_VerifyEmailViewTextEditingControllers.containsKey(OtpCodeValueKey)) {
      _VerifyEmailViewTextEditingControllers[OtpCodeValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasOtpCode =>
      this.formValueMap.containsKey(OtpCodeValueKey) &&
      (otpCodeValue?.isNotEmpty ?? false);

  bool get hasOtpCodeValidationMessage =>
      this.fieldsValidationMessages[OtpCodeValueKey]?.isNotEmpty ?? false;

  String? get otpCodeValidationMessage =>
      this.fieldsValidationMessages[OtpCodeValueKey];
}

extension Methods on FormViewModel {
  setOtpCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OtpCodeValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    otpCodeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      OtpCodeValueKey: getValidationMessage(OtpCodeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _VerifyEmailViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _VerifyEmailViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      OtpCodeValueKey: getValidationMessage(OtpCodeValueKey),
    });
