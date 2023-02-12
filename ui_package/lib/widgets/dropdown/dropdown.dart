import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../ui_package.dart';

class DefaultDropDownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Offset? offset;
  final bool requiredField;

  const DefaultDropDownField({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.valueStyle,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    this.label,
    this.labelStyle,
    this.requiredField = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(children: [
            Row(
              children: [
                Text(
                  label!,
                  style: labelStyle ??
                      getRegularStyle(
                        color: ColorManager.kDarkCharcoal,
                        fontSize: FontSize.s14,
                      ),
                ),
                if (requiredField)
                  Text(
                    '*',
                    style: getRegularStyle(
                      color: ColorManager.kRed,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: AppSize.s4,
            ),
          ]),
        DropdownButton2(
          //To avoid long text overflowing.
          isExpanded: true,
          hint: Container(
            alignment: hintAlignment,
            child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: valueStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
          value: value,
          style: valueStyle ??
              getMediumStyle(
                color: ColorManager.kPrimaryColor,
              ),
          items: dropdownItems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      alignment: valueAlignment,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getMediumStyle(
                            color: ColorManager.kPrimaryColor,
                            fontSize: FontSize.s16),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: selectedItemBuilder,
          icon: icon ?? const Icon(Icons.expand_more),
          iconSize: iconSize ?? AppSize.s18,
          iconEnabledColor: iconEnabledColor ?? ColorManager.kPrimaryColor,
          iconDisabledColor: iconDisabledColor,
          buttonHeight: buttonHeight ?? 40,
          buttonWidth: buttonWidth ?? 140,
          buttonPadding:
              buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: buttonDecoration ??
              BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  border: Border.all(
                    color: ColorManager.kTransparent,
                  ),
                  color: ColorManager.kBackgroundolor),
          buttonElevation: buttonElevation,
          itemHeight: itemHeight ?? 40,
          itemPadding:
              itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          dropdownMaxHeight: dropdownHeight ?? 200,
          dropdownWidth: dropdownWidth ?? 140,
          dropdownPadding: dropdownPadding,
          dropdownDecoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
          dropdownElevation: dropdownElevation ?? 8,
          scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
          scrollbarThickness: scrollbarThickness,
          scrollbarAlwaysShow: scrollbarAlwaysShow,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          dropdownOverButton:
              false, //Default is false to show menu below button
        ),
      ],
    ));
  }
}
