import 'package:flutter/cupertino.dart';

import '../../models/note_model.dart';
import '../hive_services/hive_note_services.dart';

class NoteServiceProvider extends ChangeNotifier {
  List<NoteModel> notes = [];

  final HiveNoteService _hiveNoteService = HiveNoteService();

  Future<bool> isNotesListEmpty({required BuildContext context}) async {
    List<NoteModel> notes = await _hiveNoteService.fetchAllNotes(
      context: context,
    );
    return notes.isEmpty;
  }

  Future<void> createInitialNote()async{
   await _hiveNoteService.createInitialNotes();
    notifyListeners();
  }
  // Store notes in local storage
  Future<void> storeNotes({
    required NoteModel note,
    required BuildContext context,
    required String mode,
  }) async {
    mode == "edit"
        ? await _hiveNoteService.updateNotes(context: context, note: note)
        : await _hiveNoteService.addNote(context: context, note: note);

    if (context.mounted) {
      await loadNotes(context: context);
    }
    notifyListeners();
  }

  // Load notes from local storage
  Future<List<NoteModel>> loadNotes({required BuildContext context}) async {
    notes = await _hiveNoteService.fetchAllNotes(context: context);
    notifyListeners();
    return notes;
  }

  Future<void> deleteNote({
    required String noteId,
    required BuildContext context,
  }) async {
    await _hiveNoteService.deleteNote(noteId: noteId, context: context);
    if (context.mounted) {
      await loadNotes(context: context);
    }
    notifyListeners();
  }
}
