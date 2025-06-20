import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  // Light mode
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      // backgroundColor: AppColors.primButtonBGColor,
      foregroundColor: AppColors.primLightMainTextColor,
      titleTextStyle: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: AppColors.primLightMainTextColor,
        fontFamily: GoogleFonts.birthstone().fontFamily,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  // Dark mode
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primButtonBGColor,
      foregroundColor: AppColors.primDarkMainTextColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    brightness: Brightness.dark,
  );
}
