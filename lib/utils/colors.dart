import 'package:flutter/material.dart';

class AppColors {
  // Light mode
  static const Color primLightScaffoldBgColor = Color(0xFFFAFAFA);
  static const Color primLightMainTextColor = Color(0xFF1C1C1E);
  static const Color primLightSecondaryTextColor = Color(0xFF6E6E73);
  static const Color primLightDividerColor = Color(0xFFE5E5EA);

  // Dark mode
  static const Color primDarkMainTextColor = Color(0xFFE5E5E5);
  static const Color primDarkSecondaryColor = Color(0xFF9E9E9E);
  static const Color primDarkDividerColor = Color(0xFF1F1F1F);

  static const Color primButtonBGColor = Color(0xFF4A90E2);
  static const Color primButtonBGColorDark = Color(0xFF0F4C75);
  static const Color primWhiteColor = Color(0xFFFFFFFF);
  static const Color primBlackColor = Color(0xFF121212);
  static const Color primDarkScaffoldColor = Color(0xFF222732);
  static const Color primGreyColor = Colors.grey;
  static const Color primSnackbarErrorColor = Colors.redAccent;
  static const Color primSnackbarDarkBGColor = Colors.black38;
  static const Color primLightGreyColor = Colors.grey;

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

  static List<List<dynamic>> noteColorsDarkAll = [
    [Color(0xFF1B262C), "Dark Navy", Color(0xFF0F4C75)],     // dark blue/navy
    [Color(0xFF4A235A), "Dark Purple", Color(0xFF6C3483)],   // deep purple
    [Color(0xFF3E4E50), "Charcoal", Color(0xFF566573)],      // dark gray blue
    [Color(0xFF154360), "Dark Cyan", Color(0xFF1A5276)],     // dark cyan/blue
    [Color(0xFF873600), "Dark Orange", Color(0xFFA04000)],   // deep orange
    [Color(0xFF512E5F), "Plum", Color(0xFF7D3C98)],          // plum purple
    [Color(0xFF641E16), "Dark Red", Color(0xFF922B21)],      // dark red/burgundy
    [Color(0xFF145A32), "Dark Green", Color(0xFF196F3D)],    // dark forest green
    [Color(0xFF0B5345), "Teal Dark", Color(0xFF117864)],     // dark teal
    [Color(0xFF4B3B39), "Brownish Dark", Color(0xFF6E4B3A)], // dark brown
  ];

}
