import 'package:flutter/material.dart';

class AppColors {
  static const Color transparent = Colors.transparent;
  static final Color whiteColor = HexColor.fromHex('#FFFFFF');
  static final Color primaryColor = HexColor.fromHex('#3BC7F3');
  static final Color black900 = HexColor.fromHex('#101010');
  static final Color cardBlue = HexColor.fromHex('#3BC7F3');
  static final Color redColor = HexColor.fromHex('#F04438');
  static final Color hintColor = HexColor.fromHex('#A3A3A3');
  static final Color darkGrey = HexColor.fromHex('#4B5563');
  static final Color borderColor = HexColor.fromHex('#DBDBDB');
  static final Color hintTextColor = HexColor.fromHex('#9CA4AB');
//green
  static final Color green500 = HexColor.fromHex('#12B76A');
  static final Color green400 = HexColor.fromHex('#32D583');
  //grey
  static final Color lightgreyE2 = HexColor.fromHex('#E2E8F0');
  static final Color grey100 = HexColor.fromHex("#F8F8F8");
  static final Color grey150 = HexColor.fromHex('#EDEEF2');
  static final Color grey200 = HexColor.fromHex('#E2E4EA');
  static final Color grey300 = HexColor.fromHex("#D1D5DB");
  static final Color grey400 = HexColor.fromHex('#9CA3AF');
  static final Color grey500 = HexColor.fromHex('#6B7280');
  static final Color grey900 = HexColor.fromHex('#111827');
  static final Color greyLightF2 = HexColor.fromHex("#F2F2F2");
  static final Color greyTextSecondary = HexColor.fromHex('#737373');
  static final Color neutralGrey = HexColor.fromHex('#F5F5F5');

  static final Color grey50 = HexColor.fromHex('#F8FAFC');
  static final Color greyFa = HexColor.fromHex('#FAFAFA');

  //blue
  static final Color lightBlue = HexColor.fromHex('#ECFAFE');
  static final Color darkBlue = HexColor.fromHex('#0075A5');
  static final Color darkBlue18 = HexColor.fromHex('#1877F2');

  //yellow
  static final yellowColor = HexColor.fromHex('#F6C33F');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    if (hexColorString == "") {
      return Colors.black;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
