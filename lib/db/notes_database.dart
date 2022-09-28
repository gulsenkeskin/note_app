import 'package:sqflite/sqflite.dart';

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

  Future _createDB(Database db, int version) async {
    //veri tabanı tablosu oluşturmak için
  }

  Future close() async {
    //daha önce oluşturduğumuz veri tabanımıza erişiriz
    final db = await instance.database;
    db.close();
  }
}
