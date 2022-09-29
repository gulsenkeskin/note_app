import 'package:flutter/material.dart';
import 'package:note_app/db/notes_database.dart';
import 'package:note_app/model/note.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  const AddEditNotePage({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey=GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;


  void addOrUpdateNote() async{
    final isValid=_formKey.currentState!.validate();

    if(isValid){
      final isUpdating= widget.note !=null;
      if(isUpdating){
        await updateNote();
      }else{
        await addNote();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateNote()async{
    final note=widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );
    await NotesDatabase.instance.update(note);
  }

  Future addNote() async{
    final note=Note(isImportant: isImportant, number: number, title: title, description: description, createdTime: DateTime.now(),);

    await NotesDatabase.instance.create(note);
  }


  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
