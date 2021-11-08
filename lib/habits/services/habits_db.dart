import 'package:lifehq/habits/constants/habits_strings.dart';
import 'package:lifehq/habits/models/done_at.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HabitsDB {
  static final HabitsDB _instance = HabitsDB._internal();
  factory HabitsDB() => _instance;
  HabitsDB._internal();

  static Database? _db;

  openDB() async {
    var database = openDatabase(
      join((await getApplicationDocumentsDirectory()).path, 'habits.db'),
      onCreate: (db, version) async {
        await db.execute("""
            CREATE TABLE habits(
              habitId INTEGER PRIMARY KEY, 
              title TEXT, 
              added INTEGER, 
              cue TEXT, 
              craving TEXT,
              response TEXT, 
              reward TEXT,
              behavior TEXT,
              hour INTEGER, 
              min INTEGER, 
              location TEXT,
              quantityString TEXT, 
              quantity INTEGER,
              bad INTEGER,
              freq INTEGER
            );
            """);

        await db.execute("""
            CREATE TABLE doneAt(
              doneAtId INTEGER PRIMARY KEY, 
              dateTime INTEGER, 
              done INTEGER,
              habitId INTEGER, 
              FOREIGN KEY (habitId) REFERENCES habits (habitId) );
            """);
      },
      version: 2,
    );

    return database;
  }

  Future<int> insertHabit(Habit habit) async {
    final Database db = await getdb;

    return await db.insert(
      HabtisStrings.HABITS,
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertDoneAt(DoneAt doneAt) async {
    final Database db = await getdb;

    return await db.insert(
      HabtisStrings.DONEAT,
      doneAt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DoneAt>> getDoneAtsofhabit(int habitId) async {
    final Database db = await getdb;

    return (await db.query(
      HabtisStrings.DONEAT,
      where: "habitId = ?",
      whereArgs: [habitId],
    ))
        .map((e) => DoneAt.fromMap(e))
        .toList();
  }

  Future<List<Habit>> getHabits() async {
    final Database db = await getdb;

    return (await db.query(HabtisStrings.HABITS))
        .map((e) => Habit.fromMap(e))
        .toList();
  }

  Future<void> editBit(Habit habit) async {
    final db = await getdb;

    await db.update(
      HabtisStrings.HABITS,
      habit.toMap(),
      where: "habitId = ?",
      whereArgs: [habit.habitId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteHabit(Habit habit) async {
    final db = await getdb;

    await db.delete(
      HabtisStrings.DONEAT,
      where: "habitId = ?",
      whereArgs: [habit.habitId],
    );

    return db.delete(
      HabtisStrings.HABITS,
      where: "habitId = ?",
      whereArgs: [habit.habitId],
    );
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
