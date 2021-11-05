import 'package:lifehq/goals/constants/strings.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GoalsDB {
  static final GoalsDB instance = GoalsDB._internal();
  factory GoalsDB() => instance;
  GoalsDB._internal();
  static Database? _db;

  Future<Database> openDB() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'goals.db'),
      onCreate: (db, version) {
        db.execute("""
            CREATE TABLE goals(
              goalId INTEGER PRIMARY KEY AUTOINCREMENT,
              goalType INTEGER,
              title TEXT,
              added INTEGER,
              deadline INTEGER,
              done INTEGER);
            """);
        db.execute("""
            CREATE TABLE tasks(
              taskId INTEGER PRIMARY KEY AUTOINCREMENT,
              text TEXT,
              date INTEGER,
              done INTEGER,
              goalId INTEGER NOT NULL,
              FOREIGN KEY (goalId) REFERENCES goals (goalId) );
            """);
      },
      version: 2,
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

  Future<int> insertGoal(Goal goal) async {
    final Database db = await getdb;

    int goalId = await db.insert(
      GoalsConstants.GOALS,
      goal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return goalId;
  }

  Future<int> insertTask(Task task) async {
    final Database db = await getdb;

    return await db.insert(
      GoalsConstants.TASKS,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Goal>> getGoals() async {
    final Database db = await getdb;

    return (await db.query(GoalsConstants.GOALS))
        .map((e) => Goal.fromMap(e))
        .toList();
  }

  Future<Goal> getGoal(int goalId) async {
    final Database db = await getdb;

    return Goal.fromMap((await db.query(
      GoalsConstants.GOALS,
      where: 'goalId = ?',
      whereArgs: [goalId],
    ))[0]);
  }

  Future<List<Task>> getTasksByDate(DateTime dateTime) async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM tasks WHERE date >= ? AND date <= ?', [
      '${DateTime(dateTime.year, dateTime.month, dateTime.day).millisecondsSinceEpoch}',
      '${DateTime(dateTime.year, dateTime.month, dateTime.day + 1).millisecondsSinceEpoch}'
    ]);

    return maps.map((e) => Task.fromMap(e)).toList();
  }

  Future<List<Task>> getTasksByGoalId(int goalId) async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps = await db.query(
      GoalsConstants.TASKS,
      where: 'goalId = ?',
      whereArgs: [goalId],
    );

    return maps.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> editTask(Task task) async {
    final db = await getdb;

    await db.update(
      GoalsConstants.TASKS,
      task.toMap(),
      where: "taskId = ?",
      whereArgs: [task.taskId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteGoal(int id) async {
    final db = await getdb;

    await db.delete(
      GoalsConstants.GOALS,
      where: "goalId = ?",
      whereArgs: [id],
    );

    await db.delete(
      GoalsConstants.TASKS,
      where: "goalId = ?",
      whereArgs: [id],
    );
  }
}
