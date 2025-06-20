import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../utils/colors.dart';

class NoteCardWidget extends StatelessWidget {
  final NoteModel noteModel;
  const NoteCardWidget({
    super.key,
    required this.noteModel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(5),
      width: screenWidth * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: noteModel.cardBgColor,
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
              color: AppColors.primWhiteColor,
              overflow: TextOverflow.ellipsis
            ),
            maxLines: 1,
          ),
          Divider(color: AppColors.primWhiteColor.withValues(alpha: 0.3),),
          SizedBox(height: 3),
          Text(
            noteModel.description,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primWhiteColor,
            ),
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
