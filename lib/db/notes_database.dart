import 'package:sqflite/sqflite.dart';

class NotesDatabase{
  static final NotesDatabase instance=NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

}