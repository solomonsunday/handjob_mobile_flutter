import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/values_manager.dart';

class PosCheckBox extends StatefulWidget {
  const PosCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.richText,
    this.checkColor = ColorManager.kWhiteColor,
    this.activeColor = ColorManager.kPrimaryColor,
  }) : super(key: key);

  final Function(bool) onChanged;
  final bool value;
  final Widget richText;
  final Color checkColor;
  final Color activeColor;

  @override
  State<PosCheckBox> createState() => _PosCheckBoxState();
}

class _PosCheckBoxState extends State<PosCheckBox> {
  bool _value = false;
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
            value: _value,
            checkColor: widget.checkColor,
            activeColor: widget.activeColor,
            onChanged: (value) {
              setState(() {
                _value = !_value;
              });

              widget.onChanged(_value);
            },
          ),
        ),
        const SizedBox(width: AppSize.s8),
        widget.richText,
      ],
    );
  }
}
