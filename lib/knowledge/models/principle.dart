import 'dart:convert';

class Principle {
  int? principleId;
  String title;
  String? subTitle;
  String? desc;
  DateTime? added;
  String? why;
  String? whyNot;

  Principle({
    this.principleId,
    required this.title,
    this.subTitle,
    this.desc,
    this.added,
    this.why,
    this.whyNot,
  });

  Map<String, dynamic> toMap() {
    return {
      'principleId': principleId,
      'title': title,
      'subTitle': subTitle,
      'desc': desc,
      'added': added?.millisecondsSinceEpoch,
      'why': why,
      'whyNot': whyNot,
    };
  }

  factory Principle.fromMap(Map<String, dynamic> map) {
    return Principle(
      principleId: map['principleId'],
      title: map['title'],
      subTitle: map['subTitle'],
      desc: map['desc'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      why: map['why'],
      whyNot: map['whyNot'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Principle.fromJson(String source) =>
      Principle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Principle(principleId: $principleId, title: $title, subTitle: $subTitle, desc: $desc, added: $added, why: $why, whyNot: $whyNot)';
  }
}
