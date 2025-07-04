import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/note_model.dart';
import '../../widgets/custom_snackbar.dart';

class HiveNoteService {
  List<NoteModel> initialNotes = [
    NoteModel(
      title: "Welcome to Quick Notes",
      noteColorIndex: 3, // keep your preferred color index
      description:
          "This is your first note! Use MyNoteWriter to jot down important reminders, ideas, and tasks. \n\nTry adding a new note by tapping the + button below.",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  // Database reference
  final _noteBox = Hive.box("notesBox");

  // Check whether user is new
  Future<bool> _isUserNew() async {
    return _noteBox.isEmpty;
  }

  Future<void> createInitialNotes() async {
    if (await _isUserNew()) {
      try {
        await _noteBox.put("notes", initialNotes);
      } catch (_) {}
    }
  }

  Future<List<NoteModel>> fetchAllNotes({required BuildContext context}) async {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    try {
      dynamic notes = _noteBox.get("notes", defaultValue: []);
      if (notes != null && notes is List<dynamic>) {
        return notes.cast<NoteModel>().toList();
      }
      return [];
    } catch (_) {
      customSnackBarWidget(
        context: context,
        title: "Error fetching notes re-open app",
        isDark: isDark,
      );
      return [];
    }
  }

  // Creating new note
  Future<void> addNote({
    required NoteModel note,
    required BuildContext context,
  }) async {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    try {
      final dynamic allNotes = await _noteBox.get("notes");
      allNotes.add(note);
      await _noteBox.put("notes", allNotes);
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Note saved.",
          isDark: isDark,
        );
      }
    } catch (_) {
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Error saving note",
          isDark: isDark,
          isError: true,
        );
      }
    }
  }

  // Update a note
  Future<void> updateNotes({
    required NoteModel note,
    required BuildContext context,
  }) async {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    try {
      // print("#################  note.id=${note.id}");
      final dynamic allNotes = await _noteBox.get("notes");
      final int index = allNotes.indexWhere((elt) {
        // print("%%%%%%%%%%%%%%%%%%%%%% ${elt.id}");
        return elt.id == note.id;
      });
      // print("#################  index=$index");

      allNotes[index] = note;
      await _noteBox.put("notes", allNotes);
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Note updated.",
          isDark: isDark,
        );
      }
    } catch (err) {
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Error updating note",
          isDark: isDark,
          isError: true,
        );
      }
    }
  }

  // Delete a note
  Future<void> deleteNote({
    required String noteId,
    required BuildContext context,
  }) async {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    try {
      final dynamic allNotes = await _noteBox.get("notes");
      allNotes.removeWhere((elt) => elt.id == noteId);
      await _noteBox.put("notes", allNotes);
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Note deleted.",
          isDark: isDark,
        );
      }
    } catch (err) {
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Error deleting note",
          isDark: isDark,
          isError: true,
        );
      }
    }
  }
}
