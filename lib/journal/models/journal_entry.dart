import 'dart:convert';
import 'package:emojis/emoji.dart';

class JournalEntry {
  int entryId;
  String title;
  String text;
  DateTime date;
  Emoji emoji;
  double latitude;
  double longitude;
  String locationDisplayName;
  List<String> medias;
  List<String> tags;
  DateTime lastModified;

  JournalEntry({
    this.entryId,
    this.title,
    this.text,
    this.date,
    this.emoji,
    this.latitude,
    this.longitude,
    this.locationDisplayName,
    this.medias,
    this.tags,
    this.lastModified,
  });

  Map<String, dynamic> toMap() {
    return {
      'entryId': entryId,
      'title': title,
      'text': text,
      'date': date.millisecondsSinceEpoch,
      'emoji': emoji.char,
      'latitude': latitude,
      'longitude': longitude,
      'locationDisplayName': locationDisplayName,
      'medias': medias.join(","),
      'tags': tags.join(","),
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      entryId: map['entryId'],
      title: map['title'],
      text: map['text'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      emoji: Emoji.byChar(map['emoji']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      locationDisplayName: map['locationDisplayName'],
      medias: map['medias'].split(","),
      tags: map['tags'].split(","),
      lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory JournalEntry.fromJson(String source) =>
      JournalEntry.fromMap(json.decode(source));
}
