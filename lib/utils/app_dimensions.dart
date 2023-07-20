import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDimensions {
  static const horizontalPadding16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const horizontalPadding24 = EdgeInsets.symmetric(horizontal: 24.0);
  static const horizontalPadding48 = EdgeInsets.symmetric(horizontal: 48.0);
  static const verticalPadding16 = EdgeInsets.symmetric(vertical: 16.0);
  static const verticalPadding24 = EdgeInsets.symmetric(vertical: 24.0);

  static Size size(BuildContext context) => MediaQuery.of(context).size;
  static final borderRadius8 = BorderRadius.circular(8.0);

  static const customTextFieldHeight = kTextTabBarHeight * 0.80;
  static const height32 = 32.0;
}
