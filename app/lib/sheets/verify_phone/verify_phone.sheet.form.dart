// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CodeValueKey = 'code';

final Map<String, TextEditingController>
    _VerifyPhoneSheetTextEditingControllers = {};

final Map<String, FocusNode> _VerifyPhoneSheetFocusNodes = {};

final Map<String, String? Function(String?)?> _VerifyPhoneSheetTextValidations =
    {
  CodeValueKey: null,
};

mixin $VerifyPhoneSheet on StatelessWidget {
  TextEditingController get codeController =>
      _getFormTextEditingController(CodeValueKey);
  FocusNode get codeFocusNode => _getFormFocusNode(CodeValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_VerifyPhoneSheetTextEditingControllers.containsKey(key)) {
      return _VerifyPhoneSheetTextEditingControllers[key]!;
    }
    _VerifyPhoneSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _VerifyPhoneSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_VerifyPhoneSheetFocusNodes.containsKey(key)) {
      return _VerifyPhoneSheetFocusNodes[key]!;
    }
    _VerifyPhoneSheetFocusNodes[key] = FocusNode();
    return _VerifyPhoneSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    codeController.addListener(() => _updateFormData(model));
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
          CodeValueKey: codeController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        CodeValueKey: _getValidationMessage(CodeValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _VerifyPhoneSheetTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_VerifyPhoneSheetTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _VerifyPhoneSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _VerifyPhoneSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _VerifyPhoneSheetTextEditingControllers.clear();
    _VerifyPhoneSheetFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get codeValue => this.formValueMap[CodeValueKey] as String?;

  bool get hasCode =>
      this.formValueMap.containsKey(CodeValueKey) &&
      (codeValue?.isNotEmpty ?? false);

  bool get hasCodeValidationMessage =>
      this.fieldsValidationMessages[CodeValueKey]?.isNotEmpty ?? false;

  String? get codeValidationMessage =>
      this.fieldsValidationMessages[CodeValueKey];
}

extension Methods on FormViewModel {
  setCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CodeValueKey] = validationMessage;
}
