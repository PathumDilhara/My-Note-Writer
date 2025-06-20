import 'package:flutter/material.dart';

import '../utils/colors.dart';

void customSnackBarWidget(
  BuildContext context,
  String title, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: TextStyle(
          color:
              isError ? AppColors.primWhiteColor : AppColors.primButtonBGColor,
        ),
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: 20, // Adjust the vertical position above the bottom
        left: 10, // Add some margin from the left
        right: 10, // Add some margin from the right
      ),
      backgroundColor:
          isError
              ? AppColors.primLightScaffoldBgColor
              : AppColors.primDarkMainTextColor,
      duration: Duration(seconds: 2),
    ),
  );
}
