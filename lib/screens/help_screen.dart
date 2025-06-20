import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  final double titleFontSize = 16;
  final double descriptionFontSize = 14;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Help Center"),
            SizedBox(width: 10),
            Icon(Icons.help_outline_rounded, size: 30),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Accordion(
              disableScrolling: true,
              headerBackgroundColor:
                  isDark
                      ? AppColors.primButtonBGColorDark
                      : AppColors.primButtonBGColor,
              headerBorderColor:
                  isDark
                      ? AppColors.primButtonBGColorDark
                      : AppColors.primButtonBGColor,
              headerBackgroundColorOpened:
                  isDark
                      ? AppColors.primButtonBGColorDark
                      : AppColors.primButtonBGColor,

              contentBackgroundColor:
                  isDark
                      ? AppColors.primButtonBGColorDark.withValues(alpha: 0.8)
                      : AppColors.primButtonBGColor.withValues(alpha: 0.5),
              contentBorderColor:
                  isDark
                      ? AppColors.primButtonBGColorDark
                      : AppColors.primButtonBGColor,

              contentBorderWidth: 2,
              contentBorderRadius: 10,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              headerBorderWidth: 3,
              headerPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              maxOpenSections: 1,
              children: [
                _buildAccordion(
                  "How do I create a new note?",
                  "Tap the '+' button on the home screen. You can then enter a title and content for your note, and customize the background color.",
                  isDark,
                  isOpen: true,
                ),
                _buildAccordion(
                  "How do I edit an existing note?",
                  "To edit a note, tap on it in your list of notes. Then press the edit icon (✏️) in the top bar.",
                  isDark,
                ),
                _buildAccordion(
                  "How do I change the note background color?",
                  "While viewing or editing a note, tap the color palette icon 🎨. You can select from multiple background colors.",
                  isDark,
                ),
                _buildAccordion(
                  "How do I delete a note?",
                  "Long-press on a note in the home screen and select the delete option, or use the delete button inside the note view.",
                  isDark,
                ),
                _buildAccordion(
                  "Is my data stored online?",
                  "No. Currently, MyNoteWriter stores your notes locally on your device. Please make backups manually if needed.",
                  isDark,
                ),
                _buildAccordion(
                  "How can I contact support?",
                  "You can contact our support team anytime by emailing us.",
                  isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AccordionSection _buildAccordion(
    String title,
    String content,
    bool isDark, {
    bool isOpen = false,
  }) {
    return AccordionSection(
      isOpen: true,
      header: Text(
        title,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
        ),
      ),
      content: SingleChildScrollView(
        child: Text(
          content,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: descriptionFontSize,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
          ),
        ),
      ),
    );
  }
}
