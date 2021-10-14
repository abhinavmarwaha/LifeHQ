import 'dart:convert';

import 'package:awesome_emojis/emoji.dart';

class Routine {
  int? routineId;
  int? routineType;
  Emoji? feel;
  int? rested;
  String? restedString;
  String? quote;
  DateTime? dateTime;
  List<String?>? treasures;

  Routine({
    this.routineId,
    this.routineType,
    this.feel,
    this.rested,
    this.restedString,
    this.quote,
    this.dateTime,
    this.treasures,
  });

  Map<String, dynamic> toMap() {
    return {
      'routineId': routineId,
      'routineType': routineType,
      'feel': feel!.char,
      'rested': rested,
      'quote': quote,
      'dateTime': dateTime!.millisecondsSinceEpoch,
      'restedString': restedString,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      routineId: map['routineId'],
      routineType: map['routineType'],
      feel: Emoji.byChar(map['feel']),
      rested: map['rested'],
      quote: map['quote'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      restedString: map['restedString'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));

  String? getRestedText() {
    switch (rested) {
      case 0:
        return "Well Rested";
      default:
        return null;
    }
  }
}
