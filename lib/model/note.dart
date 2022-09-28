final String tableNotes='notes';
//veri tabanındaki stun adlarını tanımlar
class NoteFields{
  static final String id='_id';
  static final String isImportant='isImportant';
  static final String number='number';
  static final String title='title';
  static final String description='description';
  static final String time='time';
}


class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Map<String, Object?> toJson()=>{
    NoteFields.id:id,
    NoteFields.title:title,
    NoteFields.isImportant:isImportant ? 1 :0,
    NoteFields.number:number,
    NoteFields.description:description,
    NoteFields.time:createdTime.toIso8601String(),
  };
}
