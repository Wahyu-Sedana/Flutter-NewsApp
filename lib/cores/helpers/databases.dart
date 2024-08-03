import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bookmarks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        image TEXT,
        isoDate TEXT
      )
    ''');
  }

  Future<int> insertBookmark(Map<String, dynamic> bookmark) async {
    Database db = await database;
    return await db.insert('bookmarks', bookmark);
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    Database db = await database;
    return await db.query('bookmarks');
  }

  Future<int> deleteBookmark(int id) async {
    Database db = await database;
    return await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }
}
