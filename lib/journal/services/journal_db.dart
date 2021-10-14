import 'package:lifehq/journal/constants/strings.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JournalDB {
  static final JournalDB _instance = JournalDB._internal();
  factory JournalDB() => _instance;
  JournalDB._internal();
  static Database? _db;

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
        db.execute("""
            CREATE TABLE tags(
              id INTEGER PRIMARY KEY,
              name TEXT);
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

  // Entries

  Future<int> insertEntry(JournalEntry entry) async {
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

  Future<void> deleteJournalEntry(int? id) async {
    final db = await getdb;

    await db.delete(
      JournalConstants.JOURNALENTRIES,
      where: "entryId = ?",
      whereArgs: [id],
    );
  }

  // Tags

  Future<void> insertTag(String tag) async {
    final Database db = await getdb;

    await db.insert(
      JournalConstants.TAGS,
      {'name': tag},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String?>> getTags() async {
    final Database db = await getdb;

    final List<Map<String, dynamic>> maps =
        await db.query(JournalConstants.TAGS);
        
    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }

  Future<void> editTag(String prevTag, String newTag) async {
    final db = await getdb;

    await db.update(
      JournalConstants.TAGS,
      {'name': newTag},
      where: "name = ?",
      whereArgs: [prevTag],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTag(String name) async {
    final db = await getdb;

    Batch batch = db.batch();
    batch.delete(JournalConstants.TAGS, where: "name == ?", whereArgs: [name]);
    await batch.commit();
  }
}
