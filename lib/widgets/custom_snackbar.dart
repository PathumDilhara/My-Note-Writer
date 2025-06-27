import 'package:flutter/material.dart';

import '../utils/colors.dart';

void customSnackBarWidget(
  BuildContext context,
  String title, {
  bool isError = false,
  bool isDark = true,
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
              : AppColors.primDarkMainTextColor,
      duration: Duration(seconds: 2),
    ),
  );
}
