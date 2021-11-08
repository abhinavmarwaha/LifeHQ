import 'dart:convert';

class DoneAt {
  int? doneAtId;
  final int habitId;
  final DateTime dateTime;
  final bool done;

  DoneAt({
    this.doneAtId,
    required this.habitId,
    required this.dateTime,
    required this.done,
  });

  DoneAt copyWith({
    int? doneAtId,
    int? habitId,
    DateTime? dateTime,
    bool? done,
  }) {
    return DoneAt(
      doneAtId: doneAtId ?? this.doneAtId,
      habitId: habitId ?? this.habitId,
      dateTime: dateTime ?? this.dateTime,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doneAtId': doneAtId,
      'habitId': habitId,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'done': done ? 1 : 0,
    };
  }

  factory DoneAt.fromMap(Map<String, dynamic> map) {
    return DoneAt(
      doneAtId: map['doneAtId'],
      habitId: map['habitId'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      done: map['done'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoneAt.fromJson(String source) => DoneAt.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DoneAt(doneAtId: $doneAtId, habitId: $habitId, dateTime: $dateTime, done: $done)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DoneAt &&
        other.doneAtId == doneAtId &&
        other.habitId == habitId &&
        other.dateTime == dateTime &&
        other.done == done;
  }

  @override
  int get hashCode {
    return doneAtId.hashCode ^
        habitId.hashCode ^
        dateTime.hashCode ^
        done.hashCode;
  }
}
