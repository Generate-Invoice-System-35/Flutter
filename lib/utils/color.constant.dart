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
  static LinearGradient greyGradient = LinearGradient(
    colors: [
      HexColor("#FFFFFF"),
      HexColor("#EDEAEA"),
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

  static Color homeHeaderBg = HexColor('#F2F1F1');
  static Color redLight = HexColor("#FFEDE5");
  static Color divider1 = HexColor("#E9E9E9");
  static Color inputBorder = HexColor("#E1E1E1");
  static Color backgroundIndicator = HexColor("#D9D9D9");

  static Color uploadContainerBg = HexColor("#FFFAF8");

  static Color borderBottomProfile = HexColor("#C5C5C5");

  static Color expiredStatus = HexColor("#FF5247");
  static Color notPaidStatus = HexColor("#FB7738");
  static Color pendingStatus = HexColor("#F4C500");
  static Color paidStatus = HexColor("#30AE04");

  static Color textButtonOrange = HexColor("#FF7B3C");
}
