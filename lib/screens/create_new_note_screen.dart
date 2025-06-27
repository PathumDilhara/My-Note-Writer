import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../services/provider_services/note_service_provider.dart';
import '../utils/colors.dart';

class CreateNewNoteScreen extends StatefulWidget {
  final NoteModel? noteModel;
  final String purpose;
  const CreateNewNoteScreen({super.key, this.noteModel, required this.purpose});

  @override
  State<CreateNewNoteScreen> createState() => _CreateNewNoteScreenState();
}

class _CreateNewNoteScreenState extends State<CreateNewNoteScreen> {
  final ValueNotifier<int> selectedColorNotifier = ValueNotifier(0);

  final TextEditingController _noteTitleController = TextEditingController();

  final TextEditingController _noteContentController = TextEditingController();

  final ValueNotifier<bool> _canBeSaved = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _noteTitleController.text = widget.noteModel?.title ?? "";
    _noteContentController.text = widget.noteModel?.description ?? "";
    selectedColorNotifier.value = widget.noteModel?.noteColorIndex ?? 0;
    canBeSavedData();
  }

  void canBeSavedData() {
    if (_noteTitleController.text.isNotEmpty &&
        _noteContentController.text.isNotEmpty) {
      _canBeSaved.value = true;
    } else {
      _canBeSaved.value = false;
    }
  }

  void _saveDataInDatabase({
    required NoteModel note,
    required String mode,
  }) async {
    // print("############# widget.purpose ${widget.purpose}");
    final NoteServiceProvider noteServiceProvider =
        Provider.of<NoteServiceProvider>(context, listen: false);

    if (_canBeSaved.value) {
      await noteServiceProvider.storeNotes(
        note: note,
        context: context,
        mode: mode,
      );
    }
  }

  // void _deleteNote(String noteId) {
  //   final NoteServiceProvider noteServiceProvider =
  //       Provider.of<NoteServiceProvider>(context);
  //   noteServiceProvider.deleteNote(context: context, noteId: noteId);
  // }

  @override
  Widget build(BuildContext context) {
    // print("############ noteModel.id ${widget.noteModel?.id}");
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var colorsList =
        isDark ? AppColors.noteColorsDarkAll : AppColors.noteColorsAll;

    return ValueListenableBuilder(
      valueListenable: selectedColorNotifier,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: _buildNoteTitleInputField(isDark: isDark),
            backgroundColor: colorsList[selectedColorNotifier.value][0],
            actions: [
              // Color
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _buildColorPicker(colorsList, isDark);
                    },
                  );
                },
                icon: Icon(Icons.color_lens),
              ),
              SizedBox(width: 10),

              // Save
              ValueListenableBuilder(
                valueListenable: _canBeSaved,
                builder: (context, value, child) {
                  return value
                      ? IconButton(
                        onPressed: () {
                          NoteModel note = NoteModel(
                            id: widget.noteModel?.id,
                            title: _noteTitleController.text,
                            description: _noteContentController.text,
                            noteColorIndex: selectedColorNotifier.value,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );

                          _saveDataInDatabase(note: note, mode: widget.purpose);
                          GoRouter.of(context).pop();
                        },
                        icon: Icon(
                          Icons.done,
                          color:
                              isDark
                                  ? AppColors.primWhiteColor
                                  : AppColors.primBlackColor,
                          size: 30,
                        ),
                      )
                      : SizedBox();
                },
              ),
            ],
          ),
          backgroundColor: colorsList[selectedColorNotifier.value][2],
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    // Full screen painter
                    SizedBox(
                      width: screenWidth,
                      height:
                          constraints.maxHeight > screenHeight
                              ? constraints.maxHeight
                              : screenHeight,
                      child: CustomPaint(
                        painter: RuledPaperPainter(
                          lineColor: colorsList[selectedColorNotifier.value][0]
                              .withValues(alpha: 0.3),
                          lineHeight: 32,
                        ),
                      ),
                    ),

                    // Text content
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 32,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: _buildNoteContentInputField(isDark: isDark),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildColorPicker(var colorsList, bool isDark) {
    return ValueListenableBuilder(
      valueListenable: selectedColorNotifier,
      builder: (context, value, child) {
        return AlertDialog(
          backgroundColor: colorsList[selectedColorNotifier.value][2],
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: colorsList[selectedColorNotifier.value][0],
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    color:
                        isDark
                            ? AppColors.primWhiteColor
                            : AppColors.primBlackColor,
                  ),
                ),
              ),
            ),
          ],
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1,
                ),
                itemCount: colorsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedColorNotifier.value = index;
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Icon(
                              Icons.circle,
                              color: colorsList[index][0],
                              size: 50,
                            ),
                          ),
                          if (index == selectedColorNotifier.value)
                            Positioned(
                              right: 0,
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.done,
                                color: AppColors.primWhiteColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  // Expanded(
  // child: Text(
  // colorsList[index][1],
  // style: TextStyle(
  // color: colorsList[index][0],
  // // overflow: TextOverflow.ellipsis,
  // ),
  // // maxLines: 2,
  // overflow: TextOverflow.ellipsis,
  // ),

  // Note title
  Widget _buildNoteTitleInputField({required bool isDark}) {
    return TextField(
      controller: _noteTitleController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Note title...",
        helperStyle: TextStyle(
          color: AppColors.primGreyColor,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
      maxLines: 1,
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
        canBeSavedData();
      },
      onChanged: (value) {
        canBeSavedData();
      },
    );
  }

  // Note Content
  Widget _buildNoteContentInputField({required bool isDark}) {
    return TextField(
      controller: _noteContentController,
      decoration: InputDecoration(
        hintText: "Note content...",
        hintStyle: TextStyle(
          color: AppColors.primGreyColor,
          fontWeight: FontWeight.w500,
        ),
        border: InputBorder.none,
      ),
      maxLines: 10000,
      maxLength: 10000000000,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(
        fontSize: 16,
        height: 2.0,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      onTapUpOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        canBeSavedData();
      },
    );
  }
}

class RuledPaperPainter extends CustomPainter {
  final Color lineColor;
  final double lineHeight;

  RuledPaperPainter({required this.lineColor, this.lineHeight = 32});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = lineColor
          ..strokeWidth = 1;

    double y = 0;
    while (y <= size.height) {
      // draw full horizontal line from left (0) to right (size.width)
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += lineHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
