import 'package:lifehq/knowledge/constants/strings.dart';
import 'package:lifehq/knowledge/models/principle.dart';
import 'package:lifehq/knowledge/models/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KnowledgeDB {
  static final KnowledgeDB _instance = KnowledgeDB._internal();
  factory KnowledgeDB() => _instance;
  KnowledgeDB._internal();
  static Database? _db;

  openDB() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'knowledge.db'),
      onCreate: (db, version) {
        db.execute("""
            CREATE TABLE principles(
              principleId INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              subTitle TEXT,
              desc TEXT,
              added INTEGER,
              why TEXT,
              whyNot TEXT
            );
            """);
        db.execute("""
            CREATE TABLE quotes(
              quoteId INTEGER PRIMARY KEY AUTOINCREMENT, 
              text TEXT,
              by TEXT,
              added INTEGER,
              why TEXT,
              whyNot TEXT
            );
            """);
      },
      version: 1,
    );
    return database;
  }

  Future<Database> get getdb async {
    if (_db != null) {
      return _db!;
    }
    _db = await openDB();

    return _db!;
  }

  Future close() async {
    var dbClient = await getdb;
    return dbClient.close();
  }

  // Princicples

  Future<int> insertPrinciple(Principle principle) async {
    final Database db = await getdb;

    return await db.insert(
      KnowledgeConstants.PRINCIPLES,
      principle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Principle>> getPrinciples() async {
    final Database db = await getdb;
    return (await db.query(KnowledgeConstants.PRINCIPLES))
        .map((e) => Principle.fromMap(e))
        .toList();
  }

  Future<void> deletePrinciple(int principleId) async {
    final db = await getdb;

    await db.delete(
      KnowledgeConstants.PRINCIPLES,
      where: "principleId = ?",
      whereArgs: [principleId],
    );
  }

  // Quotes

  Future<int> insertQuote(Quote quote) async {
    final Database db = await getdb;

    return await db.insert(
      KnowledgeConstants.QUOTES,
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Quote>> getQuotes() async {
    final Database db = await getdb;
    return (await db.query(KnowledgeConstants.QUOTES))
        .map((e) => Quote.fromMap(e))
        .toList();
  }

  Future<void> deleteQuote(int quoteId) async {
    final db = await getdb;

    await db.delete(
      KnowledgeConstants.PRINCIPLES,
      where: "quoteId = ?",
      whereArgs: [quoteId],
    );
  }
}
