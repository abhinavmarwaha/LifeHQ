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
      // _goals = [
      //   Goal(
      //       tasks: [
      //         Task(
      //           text: "make UI",
      //           done: false,
      //         )
      //       ],
      //       added: DateTime.now(),
      //       deadline: DateTime.now(),
      //       done: false,
      //       goalId: 1,
      //       goalType: 0,
      //       title: "Make App")
      // ];
      _goalTitle = await _db.getTodayGoalSheetTitle();
      _todayTasks = await _db.getTasksByDate(DateTime.now());
      initilised = true;
      notifyListeners();
    }
  }

  Future<int> saveGoal(Goal goal) async {
    int index = await _db.insertGoal(goal);
    goal.goalId = index;
    _goals.add(goal);
    notifyListeners();

    return index;
  }

  
}
