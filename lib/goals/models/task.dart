import 'dart:convert';
import 'goal.dart';

class Task {
  int? taskId;
  String? text;
  bool? done;
  DateTime? date;
  Goal? goal;

  Task({
    this.taskId,
    this.text,
    this.done,
    this.date,
    this.goal,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'text': text,
      'done': done! ? 1 : 0,
      'date': date!.millisecondsSinceEpoch,
      'goalId': goal!.goalId
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        taskId: map['taskId'],
        text: map['text'],
        done: map['done'] == 1,
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        goal: Goal(goalId: map['goalId']));
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
