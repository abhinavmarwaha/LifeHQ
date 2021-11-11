import 'dart:convert';

import 'package:flutter/foundation.dart';

class QA {
  final int qaId;
  final String title;
  final List<String> ques;
  final List<String> ans;

  QA({
    required this.qaId,
    required this.title,
    required this.ques,
    required this.ans,
  });

  QA copyWith({
    int? qaId,
    String? title,
    List<String>? ques,
    List<String>? ans,
  }) {
    return QA(
      qaId: qaId ?? this.qaId,
      title: title ?? this.title,
      ques: ques ?? this.ques,
      ans: ans ?? this.ans,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'qaId': qaId,
      'title': title,
      'ques': ques.join(","),
      'ans': ans.join(","),
    };
  }

  factory QA.fromMap(Map<String, dynamic> map) {
    return QA(
      qaId: map['qaId'],
      title: map['title'],
      ques: List<String>.from(map['ques'].split(',')),
      ans: List<String>.from(map['ans'].split(',')),
    );
  }

  String toJson() => json.encode(toMap());

  factory QA.fromJson(String source) => QA.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QA(qaId: $qaId, title: $title, ques: $ques, ans: $ans)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QA &&
        other.qaId == qaId &&
        other.title == title &&
        listEquals(other.ques, ques) &&
        listEquals(other.ans, ans);
  }

  @override
  int get hashCode {
    return qaId.hashCode ^ title.hashCode ^ ques.hashCode ^ ans.hashCode;
  }
}
