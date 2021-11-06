import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lifehq/habits/models/done_at.dart';

// TODO HABIT STACK

class Habit {
  int habitId;
  final String title;
  final DateTime added;
  final String cue;
  final String craving;
  final String response;
  final String reward;
  final String behavior;
  final int hour;
  final int min;
  final String location;
  List<DoneAt> doneAt;
  final String quantityString;
  final int quantity;
  final bool bad;
  final HabitFreq freq;

  Habit({
    required this.habitId,
    required this.title,
    required this.added,
    required this.cue,
    required this.craving,
    required this.response,
    required this.reward,
    required this.behavior,
    required this.hour,
    required this.min,
    required this.location,
    required this.doneAt,
    required this.quantityString,
    required this.quantity,
    required this.bad,
    required this.freq,
  });

  Habit copyWith({
    int? habitId,
    String? title,
    DateTime? added,
    String? cue,
    String? craving,
    String? response,
    String? reward,
    String? behavior,
    int? hour,
    int? min,
    String? location,
    List<DoneAt>? doneAt,
    String? quantityString,
    int? quantity,
    bool? bad,
    HabitFreq? freq,
  }) {
    return Habit(
      habitId: habitId ?? this.habitId,
      title: title ?? this.title,
      added: added ?? this.added,
      cue: cue ?? this.cue,
      craving: craving ?? this.craving,
      response: response ?? this.response,
      reward: reward ?? this.reward,
      behavior: behavior ?? this.behavior,
      hour: hour ?? this.hour,
      min: min ?? this.min,
      location: location ?? this.location,
      doneAt: doneAt ?? this.doneAt,
      quantityString: quantityString ?? this.quantityString,
      quantity: quantity ?? this.quantity,
      bad: bad ?? this.bad,
      freq: freq ?? this.freq,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'title': title,
      'added': added.millisecondsSinceEpoch,
      'cue': cue,
      'craving': craving,
      'response': response,
      'reward': reward,
      'behavior': behavior,
      'hour': hour,
      'min': min,
      'location': location,
      'quantityString': quantityString,
      'quantity': quantity,
      'bad': bad ? 1 : 0,
      'freq': freq.toInt(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      habitId: map['habitId'],
      title: map['title'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      cue: map['cue'],
      craving: map['craving'],
      response: map['response'],
      reward: map['reward'],
      behavior: map['behavior'],
      hour: map['hour'],
      min: map['min'],
      location: map['location'],
      doneAt: [],
      quantityString: map['quantityString'],
      quantity: map['quantity'],
      bad: map['bad'] == 1,
      freq: HabitFreqFromInt(map['freq']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Habit(habitId: $habitId, title: $title, added: $added, cue: $cue, craving: $craving, response: $response, reward: $reward, behavior: $behavior, hour: $hour, min: $min, location: $location, doneAt: $doneAt, quantityString: $quantityString, quantity: $quantity, bad: $bad, freq: $freq)';
  }
}

enum HabitFreq { daily, weekly, monthly }

HabitFreq HabitFreqFromInt(int freq) {
  switch (freq) {
    case 0:
      return HabitFreq.daily;
    case 1:
      return HabitFreq.weekly;
    case 2:
      return HabitFreq.monthly;
    default:
      return HabitFreq.daily;
  }
}

extension HabitFreqExtensions on HabitFreq {
  int toInt() {
    switch (this) {
      case HabitFreq.daily:
        return 0;
      case HabitFreq.weekly:
        return 1;
      case HabitFreq.monthly:
        return 2;
    }
  }
}
