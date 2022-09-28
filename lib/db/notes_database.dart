import 'package:note_app/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class NotesDatabase {
  //constructor'u çağıran instance
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  //veri tabanı bağlantısı açmak için
  //yeni veri tabanı oluşturuyoruz
  Future<Database> get database async {
    //mevcutsa var olan veri tabanını döner
    if (_database != null) return _database!;

    //yoksa veri tabanını initialize eder
    _database = await _initDB('notes.db');
    return _database!;
  }

  //veri tabanını başlatmak için
  Future<Database> _initDB(String filePath) async {
    //veri tabanını dosya depolama sisteminde saklar (file storage)
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //onCreate parametresi veri tabanı şemasını temsil eder
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id}= ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      //boş değilse map'i json objesine dönüüştür
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NoteFields.time} ASC';
    //rawquery ile: aşağıdaki db.query ile aynı işi yapar
    // final result= await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = "TEXT NOT NULL";
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = "INTEGER NOT NULL";

    //veri tabanı tablosu oluşturmak için
    await db.execute('''
    CREATE TABLE $tableNotes (
    ${NoteFields.id} $idType,
    ${NoteFields.isImportant} $boolType,
    ${NoteFields.number} $integerType,
    ${NoteFields.title} $textType,
    ${NoteFields.description} $textType,
    ${NoteFields.time} $textType, 
    )
    ''');
  }

  Future<Note> create(Note note) async {
    //veri tabanına referans
    final db = await instance.database;

    //db.insert'ün yaptığı işle aynı
/*    final json=note.toJson();
    final columns='${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';

    final values='${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';

    final id= await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');*/

    //eklemek istediğimiz tabloyu tanımlamamız gerekiyor
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future close() async {
    //daha önce oluşturduğumuz veri tabanımıza erişiriz
    final db = await instance.database;
    db.close();
  }
}
