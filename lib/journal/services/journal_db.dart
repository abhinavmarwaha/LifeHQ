import 'package:lifehq/journal/constants/strings.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JournalDB {
  static final JournalDB _instance = JournalDB._internal();
  factory JournalDB() => _instance;
  JournalDB._internal();
  static Database _db;

  openDB() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'journal.db'),
      onCreate: (db, version) {
        db.execute("""
            CREATE TABLE journalentries(
              entryId INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              text TEXT,
              date INTEGER,
              emoji TEXT,
              latitude INTEGER,
              longitude INTEGER,
              locationDisplayName TEXT,
              medias TEXT,
              tags TEXT,
              lastModified INTEGER);
            """);
      },
      version: 1,
    );
    return database;
  }

  Future<Database> get getdb async {
    if (_db != null) {
      return _db;
    }
    _db = await openDB();

    return _db;
  }

  Future close() async {
    var dbClient = await getdb;
    return dbClient.close();
  }

  Future<int> insertEntries(JournalEntry entry) async {
    final Database db = await getdb;

    return await db.insert(
      JournalConstants.JOURNALENTRIES,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<JournalEntry>> getEntries() async {
    final Database db = await getdb;
    return (await db.query(JournalConstants.JOURNALENTRIES))
        .map((e) => JournalEntry.fromMap(e))
        .toList();
  }

  Future<void> editEntry(JournalEntry journalEntry) async {
    final db = await getdb;

    await db.update(
      JournalConstants.JOURNALENTRIES,
      journalEntry.toMap(),
      where: "entryId = ?",
      whereArgs: [journalEntry.entryId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteGoal(int entryId) async {
    final db = await getdb;

    await db.delete(
      JournalConstants.JOURNALENTRIES,
      where: "entryId = ?",
      whereArgs: [entryId],
    );
  }
}
