import 'package:flutter/material.dart';

class AppColors {
  // Light mode
  static const Color primLightScaffoldBgColor = Color(0xFFFAFAFA);
  static const Color primLightMainTextColor = Color(0xFF1C1C1E);
  static const Color primLightSecondaryTextColor = Color(0xFF6E6E73);
  static const Color primLightDividerColor = Color(0xFFE5E5EA);

  // Dark mode
  static const Color primDarkScaffoldBgColor = Color(0xFF121212);
  static const Color primDarkMainTextColor = Color(0xFFE5E5E5);
  static const Color primDarkSecondaryColor = Color(0xFF9E9E9E);
  static const Color primDarkDividerColor = Color(0xFF1F1F1F);

  static const Color primButtonBGColor = Color(0xFF4A90E2);
  static const Color primWhiteColor = Color(0xFFFFFFFF);

  // static const List<MapEntry<Color, String>> noteColors = [
  //   MapEntry(Colors.indigo, "Indigo"),
  //   MapEntry(Colors.pink, "Pink"),
  //   MapEntry(Colors.yellow, "Yellow"),
  //   MapEntry(Colors.cyan, "Cyan"),
  //   MapEntry(Colors.orange, "Orange"),
  //   MapEntry(Colors.blue, "Blue"),
  //   MapEntry(Colors.purple, "Purple"),
  //   MapEntry(Colors.red, "Red"),
  //   MapEntry(Colors.teal, "Teal"),
  //   MapEntry(Colors.green, "Green"),
  // ];
  //
  // static List<Color> shadedColors = [
  //   Colors.indigo.shade100,
  //   Colors.pink.shade100,
  //   Colors.yellow.shade100,
  //   Colors.cyan.shade100,
  //   Colors.orange.shade100,
  //   Colors.blue.shade100,
  //   Colors.purple.shade100,
  //   Colors.red.shade100,
  //   Colors.teal.shade100,
  //   Colors.green.shade100,
  // ];

  static List<List<dynamic>> noteColorsAll = [
    [Colors.indigo, "Indigo", Colors.indigo.shade100],
    [Colors.pink, "Pink", Colors.pink.shade100],
    [Colors.yellow, "Yellow", Colors.yellow.shade100],
    [Colors.cyan, "Cyan", Colors.cyan.shade100],
    [Colors.orange, "Orange", Colors.orange.shade100],
    [Colors.blue, "Blue", Colors.blue.shade100],
    [Colors.purple, "Purple", Colors.purple.shade100],
    [Colors.red, "Red", Colors.red.shade100],
    [Colors.teal, "Teal", Colors.teal.shade100],
    [Colors.green, "Green", Colors.green.shade100],
  ];
}
