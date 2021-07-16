import 'package:flutter/material.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/models/task.dart';
import 'package:lifehq/goals/services/goals_db.dart';

class GoalsService with ChangeNotifier {
  static final GoalsService instance = GoalsService._internal();
  GoalsService._internal() {
    _init();
  }
  factory GoalsService() {
    return instance;
  }
  bool initilised = false;
  GoalsDB _db;

  List<Goal> _goals;
  List<Goal> get routines => _goals;
  List<Task> _todayTasks;
  List<Task> get todayTasks => _todayTasks;

  Future _init() async {
    if (!initilised) {
      _db = GoalsDB();
      _goals = await _db.getGoals();
      _todayTasks = await _db.getTasksByDate(DateTime.now());
      initilised = true;
      notifyListeners();
    }
  }
}
