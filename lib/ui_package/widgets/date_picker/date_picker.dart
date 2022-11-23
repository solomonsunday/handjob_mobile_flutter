import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/util.dart';
import '../input/input.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final Function()? clearForm;
  final Function(String) onSelected;
  final String dateFormat;
  final String? Function(String?)? validateCallBack;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  DatePicker({
    Key? key,
    this.controller,
    this.label,
    this.clearForm,
    this.focusNode,
    required this.onSelected,
    this.dateFormat = 'dd-MMM-yyyy',
    this.validateCallBack,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = TextEditingController();
    } else {
      controller = widget.controller;
    }
  }

  Future showCalender(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: widget.initialDate ?? DateTime.now(),
        firstDate: widget.firstDate ??
            DateTime.now().subtract(
              Duration(days: 200000),
            ),
        lastDate: widget.lastDate ??
            DateTime.now().add(
              Duration(days: 200000),
            ),
        fieldLabelText: widget.label);

    if (dateTime != null) {
      print(widget.dateFormat);
      final DateFormat formatter = DateFormat(widget.dateFormat);
      final String formatted = formatter.format(dateTime);
      controller!.text = formatted;
      widget.onSelected(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      onTap: () {
        Util.removeFocus(context);
        showCalender(context);
      },
      suffixIcon: GestureDetector(
        onTap: () {
          Util.removeFocus(context);
          showCalender(context);
        },
        child: const Icon(
          Icons.calendar_today_outlined,
          size: 16,
        ),
      ),
      label: widget.label ?? '',
      focusnode: widget.focusNode,
      clearForm: widget.clearForm,
      controller: controller,
      hintText: widget.hintText,
      readOnly: true,
      showCursor: false,
      validationCallback: widget.validateCallBack,
    );
  }
}
