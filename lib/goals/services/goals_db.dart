import 'package:lifehq/routine/constants/strings.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GoalsDB {
  static final GoalsDB _instance = GoalsDB._internal();
  factory GoalsDB() => _instance;
  GoalsDB._internal();
  static Database _db;

  openDB() async {
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

  Future<int> insertRoutine(Routine routine) async {
    final Database db = await getdb;

    int id = await db.insert(
      RoutineConstants.ROUTINES,
      routine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (String treasure in routine.treasures) {
      await db.insert(
        RoutineConstants.ROUTINETREASURES,
        {
          "treasure": treasure,
          "routineId": id,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return id;
  }

  Future<List<Routine>> getRoutines() async {
    final Database db = await getdb;
    List<Map<String, dynamic>> maps = await db.query(RoutineConstants.ROUTINES);
    List<Routine> routines = maps.map((map) => Routine.fromMap(map)).toList();
    for (Routine routine in routines) {
      routine.treasures = [];
      List<String> treasures = (await db.query(
        RoutineConstants.ROUTINETREASURES,
        columns: ["treasure"],
        where: "routineId = ?",
        whereArgs: [routine.routineId],
      ))
          .map<String>((e) => e["treasure"]);
      routine.treasures.addAll(treasures);
    }
    return routines;
  }

  // Future<void> editRoutine(Routine routine) async {
  //   final db = await getdb;

  //   await db.update(
  //     RoutineConstants.ROUTINES,
  //     routine.toMap(),
  //     where: "routineId = ?",
  //     whereArgs: [routine.routineId],
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  Future<void> deleteRoutine(int id) async {
    final db = await getdb;

    await db.delete(
      RoutineConstants.ROUTINES,
      where: "routineId = ?",
      whereArgs: [id],
    );

    await db.delete(
      RoutineConstants.ROUTINETREASURES,
      where: "routineId = ?",
      whereArgs: [id],
    );
  }
}
