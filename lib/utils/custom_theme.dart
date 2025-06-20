import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  // Light mode
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primButtonBGColor,
      foregroundColor: AppColors.primLightMainTextColor,
      titleTextStyle: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: AppColors.primBlackColor,
        // fontFamily: GoogleFonts.birthstone().fontFamily,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.primBlackColor),
    ),
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: AppColors.primWhiteColor,
  );

  // Dark mode
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primButtonBGColorDark,
      foregroundColor: AppColors.primDarkMainTextColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: AppColors.primWhiteColor),
    ),
    scaffoldBackgroundColor: AppColors.primDarkScaffoldColor,
    brightness: Brightness.dark,
  );
}
