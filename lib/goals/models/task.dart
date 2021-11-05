import 'dart:convert';

class Task {
  int? taskId;
  String text;
  bool done;
  DateTime? date;
  int? goalId;

  Task({
    this.taskId,
    required this.text,
    required this.done,
    this.date,
    this.goalId,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'text': text,
      'done': done ? 1 : 0,
      'date': date!.millisecondsSinceEpoch,
      'goalId': goalId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        taskId: map['taskId'],
        text: map['text'],
        done: map['done'] == 1,
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        goalId: map['goalId']);
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
