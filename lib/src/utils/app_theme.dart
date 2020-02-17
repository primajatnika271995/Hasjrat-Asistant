import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Material Color Theme
  static const Color white = Color(0xFFFFFFFF);

  // Text Color Theme
  static const Color darkText = Color(0xFF253840);

  // Font Name
  static const String fontName = 'Open-Sans';

  static const TextStyle display4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 110,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );

  static const TextStyle display3 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 54,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 42,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );
}