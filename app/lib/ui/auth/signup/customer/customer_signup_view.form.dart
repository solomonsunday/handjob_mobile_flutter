// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String FirstnameValueKey = 'firstname';
const String LastnameValueKey = 'lastname';
const String EmailValueKey = 'email';
const String PhoneValueKey = 'phone';
const String PasswordValueKey = 'password';

final Map<String, TextEditingController>
    _CustomerSignupViewTextEditingControllers = {};

final Map<String, FocusNode> _CustomerSignupViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CustomerSignupViewTextValidations = {
  FirstnameValueKey: null,
  LastnameValueKey: null,
  EmailValueKey: null,
  PhoneValueKey: null,
  PasswordValueKey: null,
};

mixin $CustomerSignupView on StatelessWidget {
  TextEditingController get firstnameController =>
      _getFormTextEditingController(FirstnameValueKey);
  TextEditingController get lastnameController =>
      _getFormTextEditingController(LastnameValueKey);
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get phoneController =>
      _getFormTextEditingController(PhoneValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  FocusNode get firstnameFocusNode => _getFormFocusNode(FirstnameValueKey);
  FocusNode get lastnameFocusNode => _getFormFocusNode(LastnameValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get phoneFocusNode => _getFormFocusNode(PhoneValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_CustomerSignupViewTextEditingControllers.containsKey(key)) {
      return _CustomerSignupViewTextEditingControllers[key]!;
    }
    _CustomerSignupViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CustomerSignupViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CustomerSignupViewFocusNodes.containsKey(key)) {
      return _CustomerSignupViewFocusNodes[key]!;
    }
    _CustomerSignupViewFocusNodes[key] = FocusNode();
    return _CustomerSignupViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    firstnameController.addListener(() => _updateFormData(model));
    lastnameController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    phoneController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
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
          FirstnameValueKey: firstnameController.text,
          LastnameValueKey: lastnameController.text,
          EmailValueKey: emailController.text,
          PhoneValueKey: phoneController.text,
          PasswordValueKey: passwordController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        FirstnameValueKey: _getValidationMessage(FirstnameValueKey),
        LastnameValueKey: _getValidationMessage(LastnameValueKey),
        EmailValueKey: _getValidationMessage(EmailValueKey),
        PhoneValueKey: _getValidationMessage(PhoneValueKey),
        PasswordValueKey: _getValidationMessage(PasswordValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _CustomerSignupViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_CustomerSignupViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CustomerSignupViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CustomerSignupViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CustomerSignupViewTextEditingControllers.clear();
    _CustomerSignupViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get firstnameValue => this.formValueMap[FirstnameValueKey] as String?;
  String? get lastnameValue => this.formValueMap[LastnameValueKey] as String?;
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get phoneValue => this.formValueMap[PhoneValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;

  bool get hasFirstname =>
      this.formValueMap.containsKey(FirstnameValueKey) &&
      (firstnameValue?.isNotEmpty ?? false);
  bool get hasLastname =>
      this.formValueMap.containsKey(LastnameValueKey) &&
      (lastnameValue?.isNotEmpty ?? false);
  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasPhone =>
      this.formValueMap.containsKey(PhoneValueKey) &&
      (phoneValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);

  bool get hasFirstnameValidationMessage =>
      this.fieldsValidationMessages[FirstnameValueKey]?.isNotEmpty ?? false;
  bool get hasLastnameValidationMessage =>
      this.fieldsValidationMessages[LastnameValueKey]?.isNotEmpty ?? false;
  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneValidationMessage =>
      this.fieldsValidationMessages[PhoneValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;

  String? get firstnameValidationMessage =>
      this.fieldsValidationMessages[FirstnameValueKey];
  String? get lastnameValidationMessage =>
      this.fieldsValidationMessages[LastnameValueKey];
  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get phoneValidationMessage =>
      this.fieldsValidationMessages[PhoneValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
}

extension Methods on FormViewModel {
  setFirstnameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FirstnameValueKey] = validationMessage;
  setLastnameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LastnameValueKey] = validationMessage;
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPhoneValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
}
