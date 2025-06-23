import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/note_model.dart';
import '../utils/app_router_paths.dart';
import '../utils/colors.dart';

class NoteViewerScreen extends StatefulWidget {
  final NoteModel noteModel;
  const NoteViewerScreen({super.key, required this.noteModel});

  @override
  State<NoteViewerScreen> createState() => _NoteViewerScreenState();
}

class _NoteViewerScreenState extends State<NoteViewerScreen> {
  final ValueNotifier<int> selectedColorNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    selectedColorNotifier.value = widget.noteModel.noteColorIndex;
  }

  String  _dateTime(DateTime dateTime) {
    String date = dateTime.toString().split(" ")[0];
    List<String> time = dateTime.toString().split(" ")[1].split(":");
    return "$date   ${time[0]}:${time[1]}";
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var colorsList =
        isDark ? AppColors.noteColorsDarkAll : AppColors.noteColorsAll;
    return ValueListenableBuilder(
      valueListenable: selectedColorNotifier,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: colorsList[selectedColorNotifier.value][2],
          appBar: AppBar(
            title: Text(
              widget.noteModel.title,
              style: TextStyle(
                fontSize: 23,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _buildColorPicker(colorsList);
                    },
                  );
                },
                icon: Icon(Icons.color_lens),
              ),
              IconButton(
                onPressed: () {
                  GoRouter.of(context).push(
                    "/${AppRouterPaths.createNewNoteScreen}",
                    extra: widget.noteModel,
                  );
                },
                icon: Icon(Icons.edit_rounded),
              ),
            ],
            backgroundColor: colorsList[selectedColorNotifier.value][0],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(_dateTime(widget.noteModel.updatedAt)),
                      ),
                    ),
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
                              .withValues(alpha: isDark ? 0.8 : 0.3),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 36),

                            Text(
                              widget.noteModel.description,
                              style: TextStyle(
                                fontSize: 16,
                                height: 2.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildColorPicker(var colorsList) {
    return ValueListenableBuilder(
      valueListenable: selectedColorNotifier,
      builder: (context, value, child) {
        return AlertDialog(
          backgroundColor: colorsList[selectedColorNotifier.value][2],
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
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
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

// SizedBox(width: 10),
// Text(
//   colorsList[index][1],
//   style: TextStyle(color: colorsList[index][0]),
// ),

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
