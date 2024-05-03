import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  DatabaseManager._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('spaces.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS spaces (
      id TEXT PRIMARY KEY,
      name TEXT,
      items TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS folders (
      id TEXT PRIMARY KEY,
      type TEXT,
      name TEXT,
      items TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS tabs (
      id TEXT PRIMARY KEY,
      type TEXT,
      name TEXT,
      url TEXT
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
