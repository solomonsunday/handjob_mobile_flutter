import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'button.dart';

enum HowItWorksType { MERCHANT_TYPE, ADMIN_TYPE }

class PosToggleButton extends StatefulWidget {
  PosToggleButton({
    Key? key,
    this.onItemSelected,
  }) : super(key: key);

  Function(HowItWorksType?)? onItemSelected;

  @override
  State<PosToggleButton> createState() => _PosToggleButtonState();
}

class _PosToggleButtonState extends State<PosToggleButton> {
  HowItWorksType _selectedType = HowItWorksType.ADMIN_TYPE;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: JBButton(
            buttonBgColor: _selectedType == HowItWorksType.ADMIN_TYPE
                ? ColorManager.kPrimaryColor
                : ColorManager.kBgSmokeWhite,
            buttonTextColor: _selectedType == HowItWorksType.ADMIN_TYPE
                ? ColorManager.kWhiteColor
                : ColorManager.kDarkCharcoal,
            borderRadiusType: BorderRadiusType.left,
            onPressed: () {
              setState(() {
                _selectedType = HowItWorksType.ADMIN_TYPE;
                widget.onItemSelected!(HowItWorksType.ADMIN_TYPE);
              });
            },
            title: 'Admin',
          ),
        ),
        Expanded(
          child: JBButton(
              buttonBgColor: _selectedType == HowItWorksType.MERCHANT_TYPE
                  ? ColorManager.kPrimaryColor
                  : ColorManager.kBgSmokeWhite,
              buttonTextColor: _selectedType == HowItWorksType.MERCHANT_TYPE
                  ? ColorManager.kWhiteColor
                  : ColorManager.kDarkCharcoal,
              borderRadiusType: BorderRadiusType.right,
              onPressed: () {
                setState(() {
                  _selectedType = HowItWorksType.MERCHANT_TYPE;
                  widget.onItemSelected!(HowItWorksType.MERCHANT_TYPE);
                });
              },
              title: 'Merchant'),
        ),
      ],
    ));
  }
}
