import 'dart:convert';

import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';

class KnowledgeFolder {
  int? id;
  final String name;
  final KnowledgeCat cat;

  KnowledgeFolder({
    this.id,
    required this.name,
    required this.cat,
  });

  KnowledgeFolder copyWith({
    int? id,
    String? name,
    KnowledgeCat? cat,
  }) {
    return KnowledgeFolder(
      id: id ?? this.id,
      name: name ?? this.name,
      cat: cat ?? this.cat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cat': cat.toInt(),
    };
  }

  factory KnowledgeFolder.fromMap(Map<String, dynamic> map) {
    return KnowledgeFolder(
      id: map['id'],
      name: map['name'],
      cat: KnowledgeCatFromInt(map['cat']),
    );
  }

  String toJson() => json.encode(toMap());

  factory KnowledgeFolder.fromJson(String source) =>
      KnowledgeFolder.fromMap(json.decode(source));

  @override
  String toString() => 'KnowledgeFolder(id: $id, name: $name, cat: $cat)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KnowledgeFolder &&
        other.id == id &&
        other.name == name &&
        other.cat == cat;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ cat.hashCode;
}
