import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class TimeLine {
  final int timelineId;
  final String title;
  final List<TimeLineItem> inits;

  TimeLine({
    required this.timelineId,
    required this.title,
    required this.inits,
  });

  TimeLine copyWith({
    int? timelineId,
    String? title,
    List<TimeLineItem>? inits,
  }) {
    return TimeLine(
      timelineId: timelineId ?? this.timelineId,
      title: title ?? this.title,
      inits: inits ?? this.inits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timelineId': timelineId,
      'title': title,
      'inits': inits.map((x) => x.toMap()).toList(),
    };
  }

  factory TimeLine.fromMap(Map<String, dynamic> map) {
    return TimeLine(
      timelineId: map['timelineId'],
      title: map['title'],
      inits: List<TimeLineItem>.from(
          map['inits']?.map((x) => TimeLineItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeLine.fromJson(String source) =>
      TimeLine.fromMap(json.decode(source));

  @override
  String toString() =>
      'TimeLine(timelineId: $timelineId, title: $title, inits: $inits)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeLine &&
        other.timelineId == timelineId &&
        other.title == title &&
        listEquals(other.inits, inits);
  }

  @override
  int get hashCode => timelineId.hashCode ^ title.hashCode ^ inits.hashCode;
}

class TimeLineItem {
  final String title;
  final List<TimeLine> next;
  TimeLineItem({
    required this.title,
    required this.next,
  });

  TimeLineItem copyWith({
    String? title,
    List<TimeLine>? next,
  }) {
    return TimeLineItem(
      title: title ?? this.title,
      next: next ?? this.next,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'next': next.map((x) => x.toMap()).toList(),
    };
  }

  factory TimeLineItem.fromMap(Map<String, dynamic> map) {
    return TimeLineItem(
      title: map['title'],
      next: List<TimeLine>.from(map['next']?.map((x) => TimeLine.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeLineItem.fromJson(String source) =>
      TimeLineItem.fromMap(json.decode(source));

  @override
  String toString() => 'TimeLineItem(title: $title, next: $next)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeLineItem &&
        other.title == title &&
        listEquals(other.next, next);
  }

  @override
  int get hashCode => title.hashCode ^ next.hashCode;
}
