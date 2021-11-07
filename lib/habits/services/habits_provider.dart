import 'package:flutter/material.dart';
import 'package:lifehq/habits/models/done_at.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/services/habits_db.dart';

class HabitsProvider with ChangeNotifier {
  static final HabitsProvider instance = HabitsProvider._internal();
  HabitsProvider._internal() {
    _init();
  }
  factory HabitsProvider() {
    return instance;
  }
  bool initilised = false;
  late HabitsDB _db;

  List<Habit> _habits = [];
  List<Habit> get habits => _habits;
  Map<int, int> _habitVal = {};
  Map<int, int> get habitVal => _habitVal;

  Future _init() async {
    if (!initilised) {
      _db = HabitsDB();
      _habits = await _db.getHabits();
      for (Habit habit in _habits) {
        habit.doneAt = await _db.getDoneAtsofhabit(habit.habitId!);
        _habitVal[habit.habitId!] = habit.calculateTrend();
      }
      initilised = true;
      notifyListeners();
    }
  }

  Future<int> saveHabit(Habit habit) async {
    int index = await _db.insertHabit(habit);
    habit.habitId = index;
    _habits.add(habit);

    notifyListeners();

    return index;
  }

  Future<void> deleteHabit(Habit habit) async {
    await _db.deleteHabit(habit);
    _habits.remove(habit);
    notifyListeners();
  }

  Future<int> insertDoneAt(DoneAt doneAt, Habit habit) async {
    int index = await _db.insertDoneAt(doneAt);
    doneAt.doneAtId = index;
    habit.doneAt.add(doneAt);

    notifyListeners();

    return index;
  }
}
