import 'package:hive_flutter/hive_flutter.dart';

import '../../models/note_model.dart';

class HiveNoteService {
  List<NoteModel> initialNotes = [
    NoteModel(
      title: "Quick Notes 🗒️",
      noteColorIndex: 3,
      description:
          "Remember to call the bank tomorrow. Backup laptop files. Buy a new mouse.",
      createdAt: DateTime(2025, DateTime.june, 11, 8, 0), // 8:00 AM
      updatedAt: DateTime(2025, DateTime.june, 11, 9, 0), // 9:00 AM
    ),
  ];

  // Database reference
  final _noteBox = Hive.box("notesBox");

  // Check whether user uis new
  Future<bool> isUserNew() async {
    return _noteBox.isEmpty;
  }

  Future<void> saveInitialNotes() async {
    if (await isUserNew()) {
      await _noteBox.put("notes", initialNotes);
    }
  }

  // Creating new note
  Future<void> addNote(NoteModel note) async {
    try {
      final dynamic allNotes = await _noteBox.get("notes");
      allNotes.add(note);
      await _noteBox.put("notes", allNotes);
    } catch (err) {
      print("##################### ${err.toString()}");
    }
  }

  // Update a note
  Future<void> updateNotes(NoteModel note) async {
    try {
      final dynamic allNotes = await _noteBox.get("notes");
      final int index = allNotes.indexWhere((elt) => elt.id == note.id);
      allNotes[index] = note;
      await _noteBox.put("notes", allNotes);
    } catch (err) {
      print("##################### ${err.toString()}");
    }
  }

  // Delete a note
  Future<void> deleteNote(NoteModel note) async {
    try {
      final dynamic allNotes = await _noteBox.get("notes");
      allNotes.removeWhere((elt) => elt.id == note.id);
      await _noteBox.put("notes", allNotes);
    } catch (err) {
      print("############### ${err.toString()}");
    }
  }
}
