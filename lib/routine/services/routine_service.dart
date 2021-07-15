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
  RoutineDB _db;

  List<Routine> _routines;
  List<Routine> get routines => _routines;

  Future _init() async {
    if (!initilised) {
      _db = RoutineDB();
      _routines = await _db.getRoutines();
      initilised = true;
      notifyListeners();
    }
  }
}
