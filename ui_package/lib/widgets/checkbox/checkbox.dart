import 'package:flutter/material.dart';

import '../../ui_package.dart';

class DefaultCheckBox extends StatefulWidget {
  DefaultCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.richText,
    this.checkColor = ColorManager.kWhiteColor,
    this.activeColor = ColorManager.kPrimaryColor,
  }) : super(key: key);

  final Function(bool) onChanged;
  bool value;
  final Widget richText;
  final Color checkColor;
  final Color activeColor;

  @override
  State<DefaultCheckBox> createState() => _DefaultCheckBoxState();
}

class _DefaultCheckBoxState extends State<DefaultCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: widget.value,
            checkColor: widget.checkColor,
            activeColor: widget.activeColor,
            onChanged: (value) {
              setState(() {
                widget.value = !widget.value;
              });

              widget.onChanged(widget.value);
            },
          ),
        ),
        const SizedBox(width: AppSize.s8),
        InkWell(
          onTap: () {
            setState(() {
              widget.value = !widget.value;
            });

            widget.onChanged(widget.value);
          },
          child: widget.richText,
        ),
      ],
    );
  }
}
