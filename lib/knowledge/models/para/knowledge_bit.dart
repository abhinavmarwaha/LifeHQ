import 'dart:convert';

import 'package:flutter/foundation.dart';

class KnowledgeBit {
  int? knowledgeBitId;
  final int knowledgeBitType;
  final String title;
  final String text;
  final DateTime added;
  final List<String> tags;
  final DateTime lastModified;

  KnowledgeBit({
    this.knowledgeBitId,
    required this.knowledgeBitType,
    required this.title,
    required this.text,
    required this.added,
    required this.tags,
    required this.lastModified,
  });

  KnowledgeBit copyWith({
    int? knowledgenBitId,
    int? knowledgenBitType,
    String? title,
    String? text,
    DateTime? added,
    List<String>? tags,
    DateTime? lastModified,
  }) {
    return KnowledgeBit(
      knowledgeBitId: knowledgenBitId ?? this.knowledgeBitId,
      knowledgeBitType: knowledgenBitType ?? this.knowledgeBitType,
      title: title ?? this.title,
      text: text ?? this.text,
      added: added ?? this.added,
      tags: tags ?? this.tags,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'knowledgeBitId': knowledgeBitId,
      'knowledgeBitType': knowledgeBitType,
      'title': title,
      'text': text,
      'added': added.millisecondsSinceEpoch,
      'tags': tags,
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory KnowledgeBit.fromMap(Map<String, dynamic> map) {
    return KnowledgeBit(
      knowledgeBitId: map['knowledgeBitId'],
      knowledgeBitType: map['knowledgeBitType'],
      title: map['title'],
      text: map['text'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      tags: List<String>.from(map['tags']),
      lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory KnowledgeBit.fromJson(String source) =>
      KnowledgeBit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KnowledgenBit(knowledgeBitId: $knowledgeBitId, knowledgeBitType: $knowledgeBitType, title: $title, text: $text, added: $added, tags: $tags, lastModified: $lastModified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KnowledgeBit &&
        other.knowledgeBitId == knowledgeBitId &&
        other.knowledgeBitType == knowledgeBitType &&
        other.title == title &&
        other.text == text &&
        other.added == added &&
        listEquals(other.tags, tags) &&
        other.lastModified == lastModified;
  }

  @override
  int get hashCode {
    return knowledgeBitId.hashCode ^
        knowledgeBitType.hashCode ^
        title.hashCode ^
        text.hashCode ^
        added.hashCode ^
        tags.hashCode ^
        lastModified.hashCode;
  }
}
