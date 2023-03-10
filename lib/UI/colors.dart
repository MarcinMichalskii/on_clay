import 'package:flutter/material.dart';

class CustomColors {
  static const darkBlue = Color.fromRGBO(44, 105, 141, 1);

  static const blue = Color.fromRGBO(89, 152, 174, 1);
  static const mainBackground = Color.fromRGBO(240, 237, 234, 1);
  static const yellow = Color.fromRGBO(233, 203, 126, 1);
  static const orange = Color.fromRGBO(230, 113, 77, 1);
  static const superLightGray = Color.fromRGBO(230, 230, 230, 1);
  static const lightGray = Color.fromRGBO(200, 200, 200, 1);
  static const gray = Color.fromRGBO(160, 160, 160, 1);
  static const darkGray = Color.fromRGBO(75, 75, 75, 1);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
