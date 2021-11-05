import 'dart:convert';

class KnowledgeBit {
  int? knowledgeBitId;
  final int knowledgeBitType;
  final String title;
  final String text;
  final DateTime added;
  final List<String> tags;
  final String folder;
  final DateTime lastModified;

  KnowledgeBit({
    this.knowledgeBitId,
    required this.knowledgeBitType,
    required this.title,
    required this.text,
    required this.added,
    required this.tags,
    required this.folder,
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
    String? folder,
  }) {
    return KnowledgeBit(
      knowledgeBitId: knowledgenBitId ?? this.knowledgeBitId,
      knowledgeBitType: knowledgenBitType ?? this.knowledgeBitType,
      title: title ?? this.title,
      text: text ?? this.text,
      added: added ?? this.added,
      tags: tags ?? this.tags,
      folder: folder ?? this.folder,
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
      'folder': folder,
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
        folder: map['folder']);
  }

  String toJson() => json.encode(toMap());

  factory KnowledgeBit.fromJson(String source) =>
      KnowledgeBit.fromMap(json.decode(source));
}
