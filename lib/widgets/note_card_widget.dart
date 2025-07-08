import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../utils/colors.dart';

class NoteCardWidget extends StatelessWidget {
  final NoteModel noteModel;
  const NoteCardWidget({super.key, required this.noteModel});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var colorsList =
        isDark ? AppColors.noteColorsDarkAll : AppColors.noteColorsAll;

    return Container(
      padding: EdgeInsets.all(5),
      width: screenWidth * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorsList[noteModel.noteColorIndex][2],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteModel.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          Divider(
            color:
                isDark
                    ? AppColors.primWhiteColor.withValues(alpha: 0.3)
                    : AppColors.primBlackColor.withValues(alpha: 0.4),
          ),
          SizedBox(height: 3),
          Text(
            noteModel.description,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color:
                  isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
            ),
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
