import 'dart:math';
import 'models/note_model.dart';

final _random = Random();

int getRandomColorIndex() => _random.nextInt(10); // 0 to 9

final testNotes = [
  NoteModel(
    title: "Grocery List 🛒",
    noteColorIndex: getRandomColorIndex(),
    description:
        "Ah, you want to display the note description on a ruled page — like lined notebook paper. The common trick is to draw horizontal lines in the background and place your text on top.",
  ),

  NoteModel(
    title: "Workout Routine 💪",
    noteColorIndex: getRandomColorIndex(),
    description: "Do 20 push-ups. Run for 30 minutes. Stretch after workout.",
  ),

  NoteModel(
    title: "Meeting Notes 📝",
    noteColorIndex: getRandomColorIndex(),
    description:
        "• Discuss Q3 marketing plan\n• Review team performance\n• Allocate new project resources\n• Set deadlines",
  ),

  NoteModel(
    title: "Travel Wishlist ✈️",
    noteColorIndex: getRandomColorIndex(),
    description:
        "• Japan - Cherry Blossom season\n• Italy - Rome & Venice\n• Iceland - Northern lights\n• Australia - Great Barrier Reef",
  ),

  NoteModel(
    title: "Daily Reflections 📖",
    noteColorIndex: getRandomColorIndex(),
    description:
        "Today I learned the importance of time management. Need to focus more on prioritizing tasks.",
  ),

  NoteModel(
    title: "Books To Read 📚",
    noteColorIndex: getRandomColorIndex(),
    description:
        "1. Atomic Habits\n2. Deep Work\n3. The Lean Startup\n4. Sapiens\n5. The Alchemist",
  ),

  NoteModel(
    title: "Ideas for Side Project 🚀",
    noteColorIndex: getRandomColorIndex(),
    description:
        "• AI-powered note app\n• Habit tracker with gamification\n• Flutter plugin for animations\n• Local service booking app",
  ),

  NoteModel(
    title: "Birthday Gift List 🎁",
    noteColorIndex: getRandomColorIndex(),
    description:
        "• Dad - Watch\n• Mom - Perfume\n• Sister - Handbag\n• Best Friend - Headphones",
  ),

  NoteModel(
    title: "Quick Notes 🗒️",
    noteColorIndex: getRandomColorIndex(),
    description:
        "Remember to call the bank tomorrow. Backup laptop files. Buy a new mouse.",
  ),

  NoteModel(
    title: "Favorite Quotes 💬",
    noteColorIndex: getRandomColorIndex(),
    description:
        "\"Success is not final; failure is not fatal: It is the courage to continue that counts.\" - Winston Churchill",
  ),
];
