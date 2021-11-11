import 'dart:convert';

import 'package:flutter/foundation.dart';

class ConsPros {
  final int consProsId;
  final DateTime added;
  final String title;
  final List<String> cons;
  final List<String> pros;
  ConsPros({
    required this.consProsId,
    required this.added,
    required this.title,
    required this.cons,
    required this.pros,
  });

  ConsPros copyWith({
    int? consProsId,
    DateTime? added,
    String? title,
    List<String>? cons,
    List<String>? pros,
  }) {
    return ConsPros(
      consProsId: consProsId ?? this.consProsId,
      added: added ?? this.added,
      title: title ?? this.title,
      cons: cons ?? this.cons,
      pros: pros ?? this.pros,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'consProsId': consProsId,
      'added': added.millisecondsSinceEpoch,
      'title': title,
      'cons': cons.join(","),
      'pros': pros.join(","),
    };
  }

  factory ConsPros.fromMap(Map<String, dynamic> map) {
    return ConsPros(
      consProsId: map['consProsId'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      title: map['title'],
      cons: map['cons'].split(","),
      pros: map['pros'].split(","),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsPros.fromJson(String source) =>
      ConsPros.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsPros(consProsId: $consProsId, added: $added, title: $title, cons: $cons, pros: $pros)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsPros &&
        other.consProsId == consProsId &&
        other.added == added &&
        other.title == title &&
        listEquals(other.cons, cons) &&
        listEquals(other.pros, pros);
  }

  @override
  int get hashCode {
    return consProsId.hashCode ^
        added.hashCode ^
        title.hashCode ^
        cons.hashCode ^
        pros.hashCode;
  }
}
