import 'package:flutter/material.dart';

import '../utils/colors.dart';

Widget customButtonWidget({
  required String label,
  required VoidCallback onPressed,
  required IconData? icon,
  required bool isDark,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: isDark? AppColors.primWhiteColor: AppColors.primBlackColor),
    label: Text(label),
    style: ElevatedButton.styleFrom(
      backgroundColor:
          isDark
              ? AppColors.primButtonBGColorDark
              : AppColors.primButtonBGColor,
      foregroundColor:
          isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(fontSize: 16),
    ),
  );
}
