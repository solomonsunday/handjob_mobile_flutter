import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.maxCount = 5,
    this.value = 3,
    this.width = 16,
    this.height = 16,
  }) : super(key: key);

  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final double width;
  final double height;

  final int maxCount;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: List.generate(
          maxCount,
          (index) => index < value
              ? SvgPicture.asset(
                  'assets/images/rating_filled.svg',
                  width: width,
                  height: height,
                )
              : SvgPicture.asset(
                  'assets/images/rating_empty.svg',
                  width: width,
                  height: height,
                )),
      // children: [
      //   SvgPicture.asset('assets/images/rating_filled.svg'),
      //   SvgPicture.asset('assets/images/rating_filled.svg'),
      //   SvgPicture.asset('assets/images/rating_empty.svg'),
      //   SvgPicture.asset('assets/images/rating_empty.svg'),
      //   SvgPicture.asset('assets/images/rating_empty.svg'),
      // ],
    );
  }
}
