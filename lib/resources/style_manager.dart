import 'package:flutter/material.dart';

class FontWeightManager {
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight regular = FontWeight.w400;
}

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}

TextStyle regularTextStyle({double fontSize = 35, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle boldTextStyle({double fontSize = 25, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
