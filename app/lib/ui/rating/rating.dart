import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  }) : super(key: key);

  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/images/rating_filled.svg'),
        SvgPicture.asset('assets/images/rating_filled.svg'),
        SvgPicture.asset('assets/images/rating_empty.svg'),
        SvgPicture.asset('assets/images/rating_empty.svg'),
        SvgPicture.asset('assets/images/rating_empty.svg'),
      ],
    );
  }
}
