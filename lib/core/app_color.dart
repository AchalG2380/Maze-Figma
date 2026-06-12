import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color primary = Color(0xFF1345C7);
  static const Color secondary = Color(0xFF1A3D99);

  // --- Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFCCCCCC);
  static const Color textGreen = Colors.green;
  static const Color textRed = Colors.red;
  static const Color textBackground = Color.fromRGBO(255, 255, 255, .5);

  static const Color down = Colors.redAccent;
  static const Color up = Colors.greenAccent;

  static const Color button = Color(0xFFFFA800);

  // --- Background / Surface ---
  static const Color background = Color(0xFF191F3F);
  static const Color lightBackground = Color.fromARGB(255, 2, 2, 108);
  static const Color surface = Color(0xFF01041F);
}
