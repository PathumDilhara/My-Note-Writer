class NoteModel {
  final String title;
  final String description;
  final int noteColorIndex;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.title,
    required this.description,
    required this.noteColorIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();
}
