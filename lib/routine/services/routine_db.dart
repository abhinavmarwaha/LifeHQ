import 'package:lifehq/routine/constants/strings.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RoutineDB {
  static final RoutineDB _instance = RoutineDB._internal();
  factory RoutineDB() => _instance;
  RoutineDB._internal();
  static Database? _db;

  Future<Database> openDB() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'routines.db'),
      onCreate: (db, version) {
        db.execute("""
            CREATE TABLE routines(
              routineId INTEGER PRIMARY KEY AUTOINCREMENT,
              routineType INTEGER,
              feel TEXT,
              restedProductive INTEGER,
              quote TEXT,
              dateTime INTEGER,
              restedProdString TEXT,
              morningGoalId INTEGER
              );
            """);
        db.execute("""
            CREATE TABLE routineTreasures(
              treasureId INTEGER PRIMARY KEY AUTOINCREMENT,
              treasure TEXT,
              routineId INTEGER NOT NULL,
              FOREIGN KEY (routineId) REFERENCES routines (routineId) );
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

  Future<int> insertRoutine(Routine routine) async {
    final Database db = await getdb;

    int id = await db.insert(
      RoutineConstants.ROUTINES,
      routine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (String? treasure in routine.treasures) {
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
    for (Routine? routine in routines) {
      routine!.treasures = [];
      List<String> treasures = (await db.query(
        RoutineConstants.ROUTINETREASURES,
        columns: ["treasure"],
        where: "routineId = ?",
        whereArgs: [routine.routineId],
      ))
          .map<String>((e) => e["treasure"] as String)
          .toList();
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
