import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color primary = Color.fromRGBO(19, 69, 199, 1);
  static const Color secondary = Color.fromRGBO(0, 24, 84, 1);

  // --- Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFCCCCCC);
  static const Color textGreen = Colors.greenAccent;
  static const Color textRed = Colors.redAccent;
  static const Color textBackground = Color.fromRGBO(255, 255, 255, 0.429);

  static const Color down = Colors.redAccent;
  static const Color up = Colors.greenAccent;

  static const Color button = Color.fromRGBO(255, 168, 0, 1);

  // --- Background / Surface ---
  static const Color background = Color.fromRGBO(1, 4, 31, 1);
  static const Color lightBackground = Color.fromRGBO(25, 61, 153, 1);
  static const Color lightDarkBackground = Color.fromRGBO(19, 24, 60, 1);
  static const Color surface = Color.fromRGBO(69, 121, 255, .2);
}
