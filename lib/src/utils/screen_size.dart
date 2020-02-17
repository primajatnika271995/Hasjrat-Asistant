import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

double paddingTop(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.padding.top;
}

double screenHeight(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.size.height;
}

double screenWidth(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.size.width;
}

double screenPixelRatio(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.devicePixelRatio;
}
