import 'dart:convert';

class Quote {
  int quoteId;
  String text;
  String by;
  DateTime added;
  String why;
  String whyNot;

  Quote({
    this.quoteId,
    this.text,
    this.by,
    this.added,
    this.why,
    this.whyNot,
  });

  Map<String, dynamic> toMap() {
    return {
      'quoteId': quoteId,
      'text': text,
      'by': by,
      'added': added.millisecondsSinceEpoch,
      'why': why,
      'whyNot': whyNot,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      quoteId: map['quoteId'],
      text: map['text'],
      by: map['by'],
      added: DateTime.fromMillisecondsSinceEpoch(map['added']),
      why: map['why'],
      whyNot: map['whyNot'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) => Quote.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Quote(quoteId: $quoteId, text: $text, by: $by, added: $added, why: $why, whyNot: $whyNot)';
  }
}
