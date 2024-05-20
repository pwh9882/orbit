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

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE IF NOT EXISTS spaceItemTreeNodes(
    id TEXT PRIMARY KEY,
    type TEXT NOT NULL,
    name TEXT NOT NULL,
    specificData TEXT,
    parentId TEXT,
    nodeIndex INTEGER NOT NULL,
    FOREIGN KEY (parentId) REFERENCES spaceItemTreeNodes(id)
  )
  ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE spaceItemTreeNodes ADD COLUMN index INTEGER NOT NULL DEFAULT 0');
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
