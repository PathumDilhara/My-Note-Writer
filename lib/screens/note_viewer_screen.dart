import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/note_model.dart';

class NoteViewerScreen extends StatelessWidget {
  final NoteModel noteModel;
  const NoteViewerScreen({super.key, required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          noteModel.title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit_rounded))],
        backgroundColor: noteModel.cardBgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 32),
        child: Form(
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: RuledPaperPainter(lineColor: Colors.grey.shade300),
                ),
              ),

              // Note Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Text(
                    noteModel.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 2.0, // line height, adjust as you like
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += lineHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
