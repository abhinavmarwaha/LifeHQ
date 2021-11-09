import 'dart:convert';
import 'dart:io' as Io;

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/services/goals_db.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/services/habits_db.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_db.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/routine/services/routine_db.dart';
import 'package:lifehq/knowledge/models/news/news_item.dart';
import 'package:lifehq/knowledge/models/news/news_rss_feed.dart';
import 'package:lifehq/knowledge/models/para/knowledge_bit.dart';
import 'package:lifehq/knowledge/models/para/knowledge_folder.dart';
import 'package:lifehq/knowledge/models/principle.dart';
import 'package:lifehq/knowledge/models/quote.dart';
import 'package:lifehq/knowledge/services/knowledge_db.dart';

import 'package:encrypt/encrypt.dart';
import 'package:nextcloud/nextcloud.dart' as nc;
import 'package:permission_handler/permission_handler.dart';

class Sync {
  Future<String> sync() async {
    List<Routine> _routines = await RoutineDB().getRoutines();
    JournalDB _journalDB = JournalDB();
    List<JournalEntry> _entries = await _journalDB.getEntries();
    List<String> _tags = await _journalDB.getTags();

    HabitsDB _habitsDB = HabitsDB();
    List<Habit> _habits = await _habitsDB.getHabits();
    for (Habit habit in _habits) {
      habit.doneAt = await _habitsDB.getDoneAtsofhabit(habit.habitId!);
    }

    GoalsDB _goalsDB = GoalsDB();
    List<Goal> _goals = await _goalsDB.getGoals();
    for (Goal goal in _goals) {
      goal.tasks = await _goalsDB.getTasksByGoalId(goal.goalId!);
    }

    KnowledgeDB _db = KnowledgeDB();
    List<KnowledgeBit> _bits = [];
    List<String> _bitTags = [];
    List<KnowledgeFolder> _folders = [];
    List<Principle> _principles = [];
    List<Quote> _quotes = [];
    List<NewsRssFeed> _feeds = [];
    List<NewsItem> _readFeedItems = [];
    List<NewsItem> _unreadFeedItems = [];
    List<NewsItem> _bookmarks = [];
    List<String> _feedTags = [];
    _principles = await _db.getPrinciples();
    _quotes = await _db.getQuotes();
    _feeds = await _db.getRssFeeds("All");
    _readFeedItems = await _db.getUnreadRssItems("All");
    _unreadFeedItems = await _db.getReadRssItems("All");
    _bookmarks = await _db.getReadRssItems("All");
    _folders = await _db.getFolders();
    _feedTags = await _db.getCategories();
    _bits = await _db.getBits();

    final storage = new FlutterSecureStorage();

    String pass = (await storage.read(key: 'password'))!;
    pass = _generateMd5(pass);

    Map<String, Map<String, dynamic>> maps = {};

    _routines.map((e) => maps['routines'] = _encrypt(e.toMap(), pass));
    _entries.map((e) => maps['entries'] = _encrypt(e.toMap(), pass));
    _tags.map((e) => maps['tags'] = _encrypt({'name': e}, pass));
    _habits.map((e) => maps['habits'] = _encrypt(e.toMap(), pass));
    _goals.map((e) => maps['goals'] = _encrypt(e.toMap(), pass));
    _bits.map((e) => maps['bits'] = _encrypt(e.toMap(), pass));
    _bitTags.map((e) => maps['bitTags'] = _encrypt({'name': e}, pass));
    _folders.map((e) => maps['folders'] = _encrypt(e.toMap(), pass));
    _principles.map((e) => maps['principles'] = _encrypt(e.toMap(), pass));
    _quotes.map((e) => maps['quotes'] = _encrypt(e.toMap(), pass));
    _feeds.map((e) => maps['feeds'] = _encrypt(e.toMap(), pass));
    _readFeedItems
        .map((e) => maps['readFeedItems'] = _encrypt(e.toMap(), pass));
    _unreadFeedItems
        .map((e) => maps['unreadFeedItems'] = _encrypt(e.toMap(), pass));
    _bookmarks.map((e) => maps['bookmarks'] = _encrypt(e.toMap(), pass));
    _feedTags.map((e) => maps['feedTags'] = _encrypt({'name': e}, pass));

    String finalJson = json.encode(maps);

    await _createFolder("LifeHQ");
    String path = await _saveJson(finalJson);

    return path;
  }

  Map<String, dynamic> _encrypt(Map<String, dynamic> map, String pass) {
    final key = Key.fromUtf8(pass);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    map = map.map((key, value) {
      final encrypted = encrypter.encrypt(value, iv: iv);

      return MapEntry(key, encrypted);
    });

    return map;
  }
}

String _generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

Future<String> _saveJson(String json) async {
  await new Future.delayed(new Duration(seconds: 1));

  if (await Permission.storage.request().isGranted) {
    var res = await _saveJsonString(json);

    return res.path;
  }

  return "";
}

Future<Io.File> _saveJsonString(String json) async {
  var dir = Io.Directory('/storage/emulated/0');
  var dirpath =
      await Io.Directory('${dir.path}/LifeHQ').create(recursive: true);

  return Io.File(
      '${dirpath.path}/${DateTime.now().toUtc().toIso8601String()}.json')
    ..writeAsStringSync(json);
}

Future<String> _createFolder(String folderName) async {
  final path = Io.Directory("/storage/emulated/0/$folderName");
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    return path.path;
  } else {
    path.create();

    return path.path;
  }
}

backupToNextCloud(String file, String name) async {
  final storage = new FlutterSecureStorage();

  String pass = (await storage.read(key: 'ncPass'))!;
  String username = (await storage.read(key: 'ncUser'))!;
  String cloud = (await storage.read(key: 'ncCloud'))!;

  final client = nc.NextCloudClient.withCredentials(
    Uri(host: cloud),
    username,
    pass,
  );

  await client.webDav.upload(Io.File(file).readAsBytesSync(), name);
}
