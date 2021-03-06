import 'package:flutter/material.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/models/task.dart';
import 'package:lifehq/goals/services/goals_db.dart';
import 'package:lifehq/routine/services/routine_service.dart';

class GoalsService with ChangeNotifier {
  static final GoalsService instance = GoalsService._internal();
  GoalsService._internal() {
    _init();
  }
  factory GoalsService() {
    return instance;
  }
  bool initilised = false;
  late GoalsDB _db;

  List<Goal> _goals = [];
  List<Goal> get goals => _goals;
  List<Task> _todayTasks = [];
  List<Task> get todayTasks => _todayTasks;

  String _goalTitle = "";
  String get goalTitle => _goalTitle;

  Future _init() async {
    if (!initilised) {
      _db = GoalsDB();
      _goals = await _db.getGoals();
      for (Goal goal in _goals) {
        goal.tasks = await _db.getTasksByGoalId(goal.goalId!);
      }
      final routines = RoutineService.instance.routines;
      if (routines.length > 0 && routines.first.morningGoalId != null) {
        int goalId = routines.first.morningGoalId!;
        try {
          _goalTitle = (await _db.getGoal(goalId)).title;
          _todayTasks = await _db.getTasksByGoalId(goalId);
        } catch (e) {}
      }
      initilised = true;
      notifyListeners();
    }
  }

  Future<int> saveGoal(Goal goal) async {
    int index = await _db.insertGoal(goal);
    goal.goalId = index;
    _goals.add(goal);

    for (Task task in goal.tasks) {
      task.goalId = index;
      await _db.insertTask(task);
    }

    notifyListeners();

    return index;
  }

  Future<void> deleteGoal(Goal goal) async {
    await _db.deleteGoal(goal.goalId!);
    _goals.remove(goal);
    notifyListeners();
  }
}
