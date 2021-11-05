import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lifehq/goals/models/task.dart';

class Goal {
  int? goalId;
  String title;
  DateTime? added;
  DateTime? deadline;
  int? goalType;
  bool done;
  List<Task> tasks;

  Goal({
    this.goalId,
    required this.title,
    this.added,
    this.deadline,
    this.goalType,
    required this.done,
    required this.tasks,
  });

  Goal copyWith({
    int? goalId,
    String? title,
    DateTime? added,
    DateTime? deadline,
    int? goalType,
    bool? done,
    List<Task>? tasks,
  }) {
    return Goal(
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      added: added ?? this.added,
      deadline: deadline ?? this.deadline,
      goalType: goalType ?? this.goalType,
      done: done ?? this.done,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goalId': goalId,
      'title': title,
      'added': added?.millisecondsSinceEpoch,
      'deadline': deadline?.millisecondsSinceEpoch,
      'goalType': goalType,
      'done': done ? 1 : 0,
      
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
      tasks: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) => Goal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Goal(goalId: $goalId, title: $title, added: $added, deadline: $deadline, goalType: $goalType, done: $done, tasks: $tasks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Goal &&
        other.goalId == goalId &&
        other.title == title &&
        other.added == added &&
        other.deadline == deadline &&
        other.goalType == goalType &&
        other.done == done &&
        listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode {
    return goalId.hashCode ^
        title.hashCode ^
        added.hashCode ^
        deadline.hashCode ^
        goalType.hashCode ^
        done.hashCode ^
        tasks.hashCode;
  }
}
