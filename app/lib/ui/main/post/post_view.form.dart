// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String TitleValueKey = 'title';
const String BodyValueKey = 'body';

final Map<String, TextEditingController> _PostViewTextEditingControllers = {};

final Map<String, FocusNode> _PostViewFocusNodes = {};

final Map<String, String? Function(String?)?> _PostViewTextValidations = {
  TitleValueKey: null,
  BodyValueKey: null,
};

mixin $PostView on StatelessWidget {
  TextEditingController get titleController =>
      _getFormTextEditingController(TitleValueKey);
  TextEditingController get bodyController =>
      _getFormTextEditingController(BodyValueKey);
  FocusNode get titleFocusNode => _getFormFocusNode(TitleValueKey);
  FocusNode get bodyFocusNode => _getFormFocusNode(BodyValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_PostViewTextEditingControllers.containsKey(key)) {
      return _PostViewTextEditingControllers[key]!;
    }
    _PostViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _PostViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_PostViewFocusNodes.containsKey(key)) {
      return _PostViewFocusNodes[key]!;
    }
    _PostViewFocusNodes[key] = FocusNode();
    return _PostViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    titleController.addListener(() => _updateFormData(model));
    bodyController.addListener(() => _updateFormData(model));
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
          TitleValueKey: titleController.text,
          BodyValueKey: bodyController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        TitleValueKey: _getValidationMessage(TitleValueKey),
        BodyValueKey: _getValidationMessage(BodyValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _PostViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_PostViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _PostViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _PostViewFocusNodes.values) {
      focusNode.dispose();
    }

    _PostViewTextEditingControllers.clear();
    _PostViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get titleValue => this.formValueMap[TitleValueKey] as String?;
  String? get bodyValue => this.formValueMap[BodyValueKey] as String?;

  bool get hasTitle =>
      this.formValueMap.containsKey(TitleValueKey) &&
      (titleValue?.isNotEmpty ?? false);
  bool get hasBody =>
      this.formValueMap.containsKey(BodyValueKey) &&
      (bodyValue?.isNotEmpty ?? false);

  bool get hasTitleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey]?.isNotEmpty ?? false;
  bool get hasBodyValidationMessage =>
      this.fieldsValidationMessages[BodyValueKey]?.isNotEmpty ?? false;

  String? get titleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey];
  String? get bodyValidationMessage =>
      this.fieldsValidationMessages[BodyValueKey];
}

extension Methods on FormViewModel {
  setTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TitleValueKey] = validationMessage;
  setBodyValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BodyValueKey] = validationMessage;
}
