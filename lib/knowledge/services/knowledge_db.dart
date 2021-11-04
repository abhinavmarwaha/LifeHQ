import 'package:lifehq/knowledge/constants/strings.dart';
import 'package:lifehq/knowledge/models/news/news_item.dart';
import 'package:lifehq/knowledge/models/news/news_rss_feed.dart';
import 'package:lifehq/knowledge/models/para/knowledge_bit.dart';
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
      onCreate: (db, version) async {
        await db.execute("""
            CREATE TABLE bits(
              knowledgeBitId INTEGER PRIMARY KEY, 
              title TEXT, 
              text TEXT,
              lastModified INTEGER, 
              added INTEGER, 
              tags TEXT, 
              knowledgeBitType INTEGER);
            """);

        await db.execute("""
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
        await db.execute("""
            CREATE TABLE quotes(
              quoteId INTEGER PRIMARY KEY AUTOINCREMENT, 
              text TEXT,
              by TEXT,
              added INTEGER,
              why TEXT,
              whyNot TEXT
            );
            """);

        await db.execute("""
            CREATE TABLE rssItems(
              feedID TEXT, 
              id INTEGER PRIMARY KEY, 
              title TEXT, desc TEXT, 
              read INTEGER, 
              catgry TEXT, 
              picURL TEXT, 
              mediaURL TEXT, 
              url TEXT, 
              pubDate TEXT, 
              author TEXT, 
              bookmarked INTEGER, 
              feedTitle TEXT);
            """);
        await db.execute("""
            CREATE TABLE rssCategories(
              id INTEGER PRIMARY KEY,
              name TEXT); 
            """);
        await db.insert(
          'rssCategories',
          {'name': "All"},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        return db.execute("""
            CREATE TABLE rssFeeds(
              feedID TEXT, 
              id INTEGER PRIMARY KEY, 
              title TEXT, 
              desc TEXT, 
              catgry TEXT, 
              picURL TEXT, 
              url TEXT, 
              lastBuildDate TEXT, 
              author TEXT, 
              atom INTEGER);
            """);
      },
      version: 1,
    );

    return database;
  }

  // Knowledge Bits

  Future<int> insertBit(KnowledgeBit bit) async {
    final Database db = await getdb;

    return await db.insert(
      KnowledgeConstants.BITS,
      bit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<KnowledgeBit>> getBits() async {
    final Database db = await getdb;

    return (await db.query(KnowledgeConstants.BITS))
        .map((e) => KnowledgeBit.fromMap(e))
        .toList();
  }

  Future<void> editBit(KnowledgeBit bit) async {
    final db = await getdb;

    await db.update(
      KnowledgeConstants.BITS,
      bit.toMap(),
      where: "knowledgenBitId = ?",
      whereArgs: [bit.knowledgeBitId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBit(int bitId) async {
    final db = await getdb;

    await db.delete(
      KnowledgeConstants.BITS,
      where: "knowledgenBitId = ?",
      whereArgs: [bitId],
    );
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

  // RSS

  // Feeds

  Future<int> insertRssFeed(NewsRssFeed feed) async {
    final Database db = await getdb;

    return db.insert(
      KnowledgeConstants.RSSFEEDS,
      feed.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NewsRssFeed>> getRssFeeds(String cat) async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps;
    maps = cat.compareTo("All") == 0
        ? await db.query(KnowledgeConstants.RSSFEEDS)
        : await db.query(KnowledgeConstants.RSSFEEDS,
            where: "catgry = ?", whereArgs: [cat]);

    return List.generate(maps.length, (i) {
      return NewsRssFeed.fromMap(maps[i]);
    });
  }

  Future<void> editRssFeed(NewsRssFeed feed) async {
    final db = await getdb;

    await db.update(
      KnowledgeConstants.RSSFEEDS,
      feed.toMap(),
      where: "id = ?",
      whereArgs: [feed.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteRssFeed(int id) async {
    final db = await getdb;

    await db.delete(KnowledgeConstants.RSSITEMS,
        where: "feedId = ?", whereArgs: [id]);

    await db.delete(
      KnowledgeConstants.RSSFEEDS,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Categories

  Future<int> insertCategory(String cat) async {
    final Database db = await getdb;

    return db.insert(
      KnowledgeConstants.RSSCATEGORIES,
      {'name': cat},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getCategories() async {
    final Database db = await getdb;

    final List<Map<String, dynamic>> maps =
        await db.query(KnowledgeConstants.RSSCATEGORIES);

    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }

  Future<int> editCategory(String prevCat, String newCat) async {
    final Database db = await getdb;

    return db.update(
      KnowledgeConstants.RSSCATEGORIES,
      {'name': newCat},
      where: "name = ?",
      whereArgs: [prevCat],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Object?>> deleteCat(String name) async {
    final db = await getdb;

    Batch batch = db.batch();
    batch.delete(KnowledgeConstants.RSSFEEDS,
        where: "catgry == ?", whereArgs: [name]);
    batch.delete(KnowledgeConstants.RSSITEMS,
        where: "catgry = ?", whereArgs: [name]);
    batch.delete(KnowledgeConstants.RSSCATEGORIES,
        where: "name = ?", whereArgs: [name]);

    return batch.commit();
  }

  // FeedItems

  Future<void> insertRssFeedtem(NewsItem item) async {
    final Database db = await getdb;

    await db.insert(
      KnowledgeConstants.RSSITEMS,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> hasFeeditem(NewsItem item) async {
    final Database db = await getdb;

    return (await db.query(KnowledgeConstants.RSSITEMS,
                where: "title = ? AND pubDate = ?",
                whereArgs: [item.title, item.pubDate]))
            .length !=
        0;
  }

  Future<List<NewsItem>> getBookmarks(String cat) async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps;
    maps = cat.compareTo("All") == 0
        ? await db.query(KnowledgeConstants.RSSITEMS,
            where: "bookmarked = ?", whereArgs: [1])
        : await db.query(KnowledgeConstants.RSSITEMS,
            where: "catgry = ? AND bookmarked = ?", whereArgs: [cat, 1]);

    return List.generate(maps.length, (i) {
      return NewsItem.fromMap(maps[i]);
    });
  }

  Future<List<NewsItem>> getReadRssItems(String cat) async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps;
    maps = cat.compareTo("All") == 0
        ? await db.query(KnowledgeConstants.RSSITEMS,
            where: "read == ?", whereArgs: [1])
        : await db.query(KnowledgeConstants.RSSITEMS,
            where: "catgry = ? AND read == ?", whereArgs: [cat, 1]);

    return List.generate(maps.length, (i) {
      return NewsItem.fromMap(maps[i]);
    });
  }

  Future<List<NewsItem>> getUnreadRssItems(String cat) async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps;
    maps = cat.compareTo("All") == 0
        ? await db.query(KnowledgeConstants.RSSITEMS,
            where: "read == ?", whereArgs: [0])
        : await db.query(KnowledgeConstants.RSSITEMS,
            where: "catgry = ? AND read == ?", whereArgs: [cat, 0]);

    return List.generate(maps.length, (i) {
      return NewsItem.fromMap(maps[i]);
    });
  }

  Future<void> editRssFeedItem(NewsItem feedItem) async {
    final db = await getdb;

    await db.update(
      KnowledgeConstants.RSSITEMS,
      feedItem.toMap(),
      where: "id = ?",
      whereArgs: [feedItem.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteRssItem(NewsItem item) async {
    final db = await getdb;

    return db.delete(KnowledgeConstants.RSSITEMS,
        where: "id = ?", whereArgs: [item.id]);
  }

  // db utils

  Future<Database> get getdb async {
    if (_db != null) {
      return _db!;
    }
    _db = await openDB();

    return _db!;
  }

  Future<void> clearTable(String dbName) async {
    final db = await getdb;
    await db.delete(dbName);
  }

  Future close() async {
    var dbClient = await getdb;

    return dbClient.close();
  }
}
