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
    createdAt: DateTime(2025, DateTime.june, 20, 14, 30), // 2:30 PM
    updatedAt: DateTime(2025, DateTime.june, 23, 9, 15), // 9:15 AM
  ),

  NoteModel(
    title: "Workout Routine 💪",
    noteColorIndex: getRandomColorIndex(),
    description: "Do 20 push-ups. Run for 30 minutes. Stretch after workout.",
    createdAt: DateTime(2025, DateTime.june, 15, 7, 0), // 7:00 AM
    updatedAt: DateTime(2025, DateTime.june, 18, 7, 30), // 7:30 AM
  ),

  NoteModel(
    title: "Meeting Notes 📝",
    noteColorIndex: getRandomColorIndex(),
    description:
    "• Discuss Q3 marketing plan\n• Review team performance\n• Allocate new project resources\n• Set deadlines",
    createdAt: DateTime(2025, DateTime.june, 10, 10, 0), // 10:00 AM
    updatedAt: DateTime(2025, DateTime.june, 12, 11, 45), // 11:45 AM
  ),

  NoteModel(
    title: "Travel Wishlist ✈️",
    noteColorIndex: getRandomColorIndex(),
    description:
    "• Japan - Cherry Blossom season\n• Italy - Rome & Venice\n• Iceland - Northern lights\n• Australia - Great Barrier Reef",
    createdAt: DateTime(2025, DateTime.may, 28, 16, 20), // 4:20 PM
    updatedAt: DateTime(2025, DateTime.june, 2, 17, 0), // 5:00 PM
  ),

  NoteModel(
    title: "Daily Reflections 📖",
    noteColorIndex: getRandomColorIndex(),
    description:
    "Today I learned the importance of time management. Need to focus more on prioritizing tasks.",
    createdAt: DateTime(2025, DateTime.june, 21, 21, 30), // 9:30 PM
    updatedAt: DateTime(2025, DateTime.june, 22, 22, 15), // 10:15 PM
  ),

  NoteModel(
    title: "Books To Read 📚",
    noteColorIndex: getRandomColorIndex(),
    description:
    "1. Atomic Habits\n2. Deep Work\n3. The Lean Startup\n4. Sapiens\n5. The Alchemist",
    createdAt: DateTime(2025, DateTime.june, 1, 18, 0), // 6:00 PM
    updatedAt: DateTime(2025, DateTime.june, 3, 19, 0), // 7:00 PM
  ),

  NoteModel(
    title: "Ideas for Side Project 🚀",
    noteColorIndex: getRandomColorIndex(),
    description:
    "• AI-powered note app\n• Habit tracker with gamification\n• Flutter plugin for animations\n• Local service booking app",
    createdAt: DateTime(2025, DateTime.june, 5, 13, 15), // 1:15 PM
    updatedAt: DateTime(2025, DateTime.june, 6, 13, 45), // 1:45 PM
  ),

  NoteModel(
    title: "Birthday Gift List 🎁",
    noteColorIndex: getRandomColorIndex(),
    description:
    "• Dad - Watch\n• Mom - Perfume\n• Sister - Handbag\n• Best Friend - Headphones",
    createdAt: DateTime(2025, DateTime.may, 30, 20, 0), // 8:00 PM
    updatedAt: DateTime(2025, DateTime.june, 4, 20, 30), // 8:30 PM
  ),

  NoteModel(
    title: "Quick Notes 🗒️",
    noteColorIndex: getRandomColorIndex(),
    description:
    "Remember to call the bank tomorrow. Backup laptop files. Buy a new mouse.",
    createdAt: DateTime(2025, DateTime.june, 11, 8, 0), // 8:00 AM
    updatedAt: DateTime(2025, DateTime.june, 11, 9, 0), // 9:00 AM
  ),

  NoteModel(
    title: "Favorite Quotes 💬",
    noteColorIndex: getRandomColorIndex(),
    description:
    "\"Success is not final; failure is not fatal: It is the courage to continue that counts.\" - Winston Churchill",
    createdAt: DateTime(2025, DateTime.june, 7, 15, 0), // 3:00 PM
    updatedAt: DateTime(2025, DateTime.june, 7, 15, 0), // 3:00 PM
  ),
];
