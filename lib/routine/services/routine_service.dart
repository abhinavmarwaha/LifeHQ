import 'package:flutter/material.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/routine/services/routine_db.dart';

class RoutineService with ChangeNotifier {
  static final RoutineService instance = RoutineService._internal();
  RoutineService._internal() {
    _init();
  }
  factory RoutineService() {
    return instance;
  }
  bool initilised = false;
  late RoutineDB _db;

  List<Routine> _routines = [];
  List<Routine> get routines => _routines;

  Routine? goingOnRoutine;

  Future _init() async {
    if (!initilised) {
      _db = RoutineDB();
      _routines = await _db.getRoutines();
      initilised = true;
      notifyListeners();
    }
  }

  // TODO confusion between day and night
  // 0 => morn, 1 => even, -1 => nothing
  int checkIfRoutined() {
    final now = DateTime.now();
    final mornStart =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final mornEnd =
        DateTime(now.year, now.month, now.day, 15).millisecondsSinceEpoch;
    final evenEnd =
        DateTime(now.year, now.month, now.day + 1).millisecondsSinceEpoch;
    if (now.millisecondsSinceEpoch < mornEnd) {
      for (Routine? routine in _routines) {
        if (routine!.routineType == 0 &&
            routine.dateTime.millisecondsSinceEpoch > mornStart &&
            routine.dateTime.millisecondsSinceEpoch < mornEnd) {
          return -1;
        }
      }

      return 0;
    } else {
      for (Routine? routine in _routines) {
        if (routine!.routineType == 1 &&
            routine.dateTime.millisecondsSinceEpoch > mornEnd &&
            routine.dateTime.millisecondsSinceEpoch < evenEnd) {
          return -1;
        }
      }

      return 1;
    }
  }

  void startRoutine(int type) {
    goingOnRoutine = Routine(
        dateTime: DateTime.now(),
        routineType: type,
        treasures: [],
        morningGoalId: null);
  }

  Future<int> saveRoutine() async {
    int index = await _db.insertRoutine(goingOnRoutine!);
    goingOnRoutine!.routineId = index;
    _routines.add(goingOnRoutine!);
    goingOnRoutine = null;

    return index;
  }
}
