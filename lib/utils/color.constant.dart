// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorConstant {
  static LinearGradient orangeGradient = LinearGradient(
    colors: [
      HexColor("#F75000"),
      HexColor("#FF9F71"),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Color darkBlue = HexColor("#09273E");
  static Color orangeSolid = HexColor("#F75000");
  static Color orangeLight = HexColor("#FF9F71");
  static Color greenLight = HexColor("#AEF2A8");
  static Color blueLight = HexColor("#BEF9F9");
  static Color purpleLight = HexColor("#E29CF2");
  static Color greenLime = HexColor("#E3FFB5");
  static Color lightGray = HexColor("#9C9C9C");
  static Color white = HexColor("#FFFFFF");
}