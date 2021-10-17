import 'dart:convert';
import 'goal.dart';

class Task {
  int? taskId;
  String? text;
  bool? done;
  DateTime? date;

  Task({
    this.taskId,
    this.text,
    this.done,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'text': text,
      'done': done! ? 1 : 0,
      'date': date!.millisecondsSinceEpoch,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['taskId'],
      text: map['text'],
      done: map['done'] == 1,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
