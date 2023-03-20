import 'package:flutter/material.dart';

import '../../ui_package.dart';

class SearchInput extends StatelessWidget {
  final AutovalidateMode? autovalidateMode;
  final TextAlign? textAlign;
  final TextInputType? keyBoardType;
  final String? Function(String? val)? validationCallback;
  final void Function()? onEdittingComplete;
  final String? formError;
  final String label;
  final String? hintText;
  final FocusNode? focusnode;
  final TextEditingController? controller;
  final String? message;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Function()? clearForm;
  final Function()? onTap;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool? enabled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Color? fillColor;
  final Color? hintColor;
  final bool? showCursor;
  final bool readOnly;
  final Widget? labelRightItem;
  final TextStyle? labelStyle;
  final int? minLines;
  final String? initialValue;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingBottom;
  final bool requiredField;

  const SearchInput({
    this.autovalidateMode,
    this.textAlign,
    this.keyBoardType,
    this.onEdittingComplete,
    this.validationCallback,
    this.message,
    this.hintText,
    this.label = '',
    this.requiredField = false,
    this.formError,
    this.focusnode,
    this.controller,
    this.clearForm,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minLines,
    this.enabled = true,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.fillColor,
    this.hintColor,
    this.showCursor,
    this.readOnly = false,
    this.labelRightItem,
    this.labelStyle,
    this.initialValue,
    this.paddingLeft,
    this.paddingBottom,
    this.paddingTop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: TextFormField(
        initialValue: initialValue,
        showCursor: showCursor,
        readOnly: readOnly,
        enabled: enabled,
        onTap: onTap,
        autovalidateMode: autovalidateMode,
        focusNode: focusnode,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          counterText: '',
          hintStyle: getRegularStyle(
            color: hintColor ?? ColorManager.kGrey2,
            fontSize: FontSize.s12,
          ),
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorManager.kGrey2),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorManager.kGrey2),
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorManager.kGrey2),
              ),
          // alignLabelWithHint: true,
          // labelText: label,
          isDense: true,
          hintText: hintText,
          errorText: formError,
          contentPadding: const EdgeInsets.only(
            top: 16,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor ?? ColorManager.kInputBgColor,
          filled: true,
        ),
        textAlign: textAlign ?? TextAlign.start,
        style: getRegularStyle(
          color: ColorManager.kDarkCharcoal,
          fontSize: FontSize.s12,
        ),
        validator: validationCallback,
        keyboardType: keyBoardType,
        onChanged: onChanged,
        onEditingComplete: onEdittingComplete,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
