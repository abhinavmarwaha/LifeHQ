import 'dart:convert';

class Goal {
  int? goalId;
  String? title;
  DateTime? added;
  DateTime? deadline;
  int? goalType;
  bool? done;

  Goal({
    this.goalId,
    this.title,
    this.added,
    this.deadline,
    this.goalType,
    this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'goalId': goalId,
      'title': title,
      'added': added!.millisecondsSinceEpoch,
      'deadline': deadline!.millisecondsSinceEpoch,
      'goalType': goalType,
      'done': done! ? 1 : 0,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      goalId: map['goalId'],
      title: map['title'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline']),
      goalType: map['goalType'],
      done: map['done'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) => Goal.fromMap(json.decode(source));
}
