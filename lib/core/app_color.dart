import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color primary = Color.fromRGBO(19, 69, 199, 1);
  static const Color secondary = Color.fromRGBO(0, 24, 84, 1);

  // --- Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFCCCCCC);
  static const Color lightText = Color(0xFF8A8A8A);
  static const Color textGreen = Colors.greenAccent;
  static const Color textRed = Colors.redAccent;
  static const Color textBackground = Color.fromRGBO(255, 255, 255, 0.47);

  static const Color high = Color.fromRGBO(18, 221, 0, 1);
  static const Color low = Color.fromRGBO(255, 63, 63, 1);
  static const Color greenBar = Color.fromARGB(50, 76, 175, 79);
  static const Color redBar = Color.fromARGB(50, 255, 102, 0);
  static const Color oderbookGreen = Color.fromRGBO(0, 239, 196, 1);
  static const Color oderbookGreenBlur = Color.fromRGBO(0, 239, 196, 0);
  static const Color oderbookRed = Color.fromRGBO(255, 63, 63, 1);
  static const Color oderbookRedBlur = Color.fromRGBO(255, 63, 63, 0);

  static const Color button = Color.fromRGBO(255, 168, 0, 1);
  static const Color button2 = Color.fromRGBO(84, 94, 83, 1);
  static const Color buyButton = Color.fromRGBO(9, 113, 0, 1);
  static const Color sellButton = Color.fromRGBO(251, 75, 75, 1);

  // --- Background / Surface ---
  static const Color background = Color.fromRGBO(1, 4, 31, 1);
  static const Color lightBackground = Color.fromRGBO(25, 61, 153, 1);
  static const Color lightDarkBackground = Color.fromRGBO(19, 24, 60, 1);
  static const Color surface = Color.fromRGBO(69, 121, 255, .2);
}
