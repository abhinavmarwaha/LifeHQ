import 'dart:convert';

import 'package:awesome_emojis/emoji.dart';

class Routine {
  int? routineId;
  int routineType;
  Emoji? feel;
  int? restedProductive;
  String? restedProdString;
  String? quote;
  DateTime dateTime;
  List<String> treasures;
  int? morningGoalId;

  Routine({
    this.routineId,
    required this.routineType,
    this.feel,
    this.restedProductive,
    this.restedProdString,
    this.quote,
    required this.dateTime,
    required this.treasures,
    required this.morningGoalId,
  });

  Map<String, dynamic> toMap() {
    return {
      'routineId': routineId,
      'routineType': routineType,
      'feel': feel!.char,
      'restedProductive': restedProductive,
      'quote': quote,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'restedProdString': restedProdString,
      'morningGoalId': morningGoalId,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
        routineId: map['routineId'],
        routineType: map['routineType'],
        feel: Emoji.byChar(map['feel']),
        restedProductive: map['restedProductive'],
        quote: map['quote'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
        restedProdString: map['restedProdString'],
        treasures: [],
        morningGoalId: map['morningGoalId']);
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));

  String getProdRestedText() {
    switch (restedProductive) {
      case 0:
        return restedProdString! + "Worked";
      case 1:
        return routineType == 0
            ? "Was not rested due to " + restedProdString!
            : "Was not productive due to " + restedProdString!;
      case 2:
        return "Was confused due to " + restedProdString!;
      case 3:
        return routineType == 0
            ? restedProdString! + "rested"
            : restedProdString! + "productive";
      default:
        return "";
    }
  }
}
