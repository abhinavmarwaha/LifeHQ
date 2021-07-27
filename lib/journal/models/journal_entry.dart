import 'dart:convert';

class JournalEntry {
  int entryId;
  String title;
  String text;
  DateTime date;
  double latitude;
  double longitude;
  String locationDisplayName;
  List<String> tags;
  DateTime lastModified;

  JournalEntry({
    this.entryId,
    this.title,
    this.text,
    this.date,
    this.latitude,
    this.longitude,
    this.locationDisplayName,
    this.tags,
    this.lastModified,
  });

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'title': title,
      'text': text,
      'date': date.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
      'locationDisplayName': locationDisplayName,
      'tags': tags?.join(","),
      'lastModified': lastModified?.millisecondsSinceEpoch,
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      entryId: map['entryId'],
      title: map['title'],
      text: map['text'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      locationDisplayName: map['locationDisplayName'],
      tags: map['tags']?.split(","),
      lastModified: map['lastModified'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastModified'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JournalEntry.fromJson(String source) =>
      JournalEntry.fromMap(json.decode(source));
}
