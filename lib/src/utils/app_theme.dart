import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Material Color Theme
  static const Color white = Color(0xFFFFFFFF);

  // Text Color Theme
  static const Color darkText = Color(0xFF253840);

  // Font Name
  static const String fontName = 'Open-Sans';

  static const TextStyle selamatDatangStyle = TextStyle(
    fontFamily: fontName,
    color: Colors.white,
    fontSize: 16,
    letterSpacing: 1.5,
  );

  static const TextStyle namaSalesStyle = TextStyle(
    fontFamily: fontName,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 1.5,
  );
}