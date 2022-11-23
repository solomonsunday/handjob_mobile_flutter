import 'package:flutter/material.dart';

class AppMargin {
  static const double m8 = 8.0;
  static const double m10 = 10.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m80 = 80.0;
  static const double m120 = 120.0;
}

class AppPadding {
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p28 = 28.0;
  static const double p30 = 30.0;
  static const double p40 = 40.0;
}

class AppSize {
  static const double s0 = 0;
  static const double s1_5 = 1.5;
  static const double s4 = 4.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s28 = 28.0;
  static const double s32 = 32.0;
  static const double s40 = 40.0;
  static const double s48 = 48.0;
  static const double s60 = 60.0;
  static const double s64 = 64.0;
  static const double s65 = 65.0;
  static const double s80 = 80.0;
  static const double s100 = 100.0;
  static const double s110 = 110.0;
  static const double s120 = 120.0;
  static const double s184 = 184.0;
  static const double s220 = 220.0;
  static const double s320 = 320.0;

  static const double s56 = 56.0;
}

// ignore: constant_identifier_names
const ScreenHorizontalSize = 16.0;
const ScreenVerticalSize = 40.0;

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// Returns the pixel amount for the percentage of the screen height. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens height
double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;
