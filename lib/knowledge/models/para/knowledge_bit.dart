import 'dart:convert';

import 'package:flutter/foundation.dart';

class KnowledgenBit {
  int knowledgenBitId;
  final int knowledgenBitType;
  final String title;
  final String text;
  final DateTime added;
  final List<String> tags;
  final DateTime lastModified;

  KnowledgenBit({
    required this.knowledgenBitId,
    required this.knowledgenBitType,
    required this.title,
    required this.text,
    required this.added,
    required this.tags,
    required this.lastModified,
  });

  KnowledgenBit copyWith({
    int? knowledgenBitId,
    int? knowledgenBitType,
    String? title,
    String? text,
    DateTime? added,
    List<String>? tags,
    DateTime? lastModified,
  }) {
    return KnowledgenBit(
      knowledgenBitId: knowledgenBitId ?? this.knowledgenBitId,
      knowledgenBitType: knowledgenBitType ?? this.knowledgenBitType,
      title: title ?? this.title,
      text: text ?? this.text,
      added: added ?? this.added,
      tags: tags ?? this.tags,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'knowledgenBitId': knowledgenBitId,
      'knowledgenBitType': knowledgenBitType,
      'title': title,
      'text': text,
      'added': added.millisecondsSinceEpoch,
      'tags': tags,
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory KnowledgenBit.fromMap(Map<String, dynamic> map) {
    return KnowledgenBit(
      knowledgenBitId: map['knowledgenBitId'],
      knowledgenBitType: map['knowledgenBitType'],
      title: map['title'],
      text: map['text'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      tags: List<String>.from(map['tags']),
      lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory KnowledgenBit.fromJson(String source) =>
      KnowledgenBit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KnowledgenBit(knowledgenBitId: $knowledgenBitId, knowledgenBitType: $knowledgenBitType, title: $title, text: $text, added: $added, tags: $tags, lastModified: $lastModified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KnowledgenBit &&
        other.knowledgenBitId == knowledgenBitId &&
        other.knowledgenBitType == knowledgenBitType &&
        other.title == title &&
        other.text == text &&
        other.added == added &&
        listEquals(other.tags, tags) &&
        other.lastModified == lastModified;
  }

  @override
  int get hashCode {
    return knowledgenBitId.hashCode ^
        knowledgenBitType.hashCode ^
        title.hashCode ^
        text.hashCode ^
        added.hashCode ^
        tags.hashCode ^
        lastModified.hashCode;
  }
}
