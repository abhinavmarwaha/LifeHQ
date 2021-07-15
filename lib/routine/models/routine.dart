import 'dart:convert';

import 'package:emojis/emoji.dart';

class Routine {
  int routineId;
  int routineType;
  Emoji feel;
  int rested;
  String restedString;
  DateTime dateTime;
  List<String> treasures;

  Routine({
    this.routineId,
    this.routineType,
    this.feel,
    this.rested,
    this.restedString,
    this.dateTime,
    this.treasures,
  });

  Map<String, dynamic> toMap() {
    return {
      'routineId': routineId,
      'routineType': routineType,
      'feel': feel.char,
      'rested': rested,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'restedString': restedString,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      routineId: map['routineId'],
      routineType: map['routineType'],
      feel: Emoji.byChar(map['feel']),
      rested: map['rested'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      restedString: map['restedString'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));
}
