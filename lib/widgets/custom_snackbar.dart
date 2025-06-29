import 'package:flutter/material.dart';

import '../utils/colors.dart';

void customSnackBarWidget({
  required BuildContext context,
  required String title,
  required bool isDark,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: TextStyle(
          color: isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
        ),
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: 0, // Adjust the vertical position above the bottom
        left: 10, // Add some margin from the left
        right: 10, // Add some margin from the right
      ),
      backgroundColor:
          isError
              ? AppColors.primSnackbarErrorColor
              : isDark
              ? AppColors.primSnackbarDarkBGColor
              : AppColors.primButtonBGColor.withValues(alpha: 0.3),
      duration: Duration(seconds: 2),
    ),
  );
}
