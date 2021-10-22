import 'package:flutter/material.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_db.dart';

class JournalService with ChangeNotifier {
  static final JournalService instance = JournalService._internal();
  JournalService._internal() {
    _init();
  }
  factory JournalService() {
    return instance;
  }
  bool initilised = false;
  late JournalDB _db;

  List<JournalEntry> _entries = [];
  List<JournalEntry> get entries => _entries;
  List<String> _tags = [];
  List<String> get tags => _tags;

  Future _init() async {
    if (!initilised) {
      _db = JournalDB();
      _entries = await _db.getEntries();
      _tags.add("All");
      _tags = await _db.getTags();
      initilised = true;
      notifyListeners();
    }
  }

  Future<int> saveJournalEntry(JournalEntry entry) async {
    int index = await _db.insertEntry(entry);
    entry.entryId = index;
    _entries.add(entry);
    notifyListeners();
    
    return index;
  }

  Future deleteJournalEntry(JournalEntry journalEntry) async {
    await _db.deleteJournalEntry(journalEntry.entryId);
    _entries.remove(journalEntry);
    notifyListeners();
  }

  Future insertTag(String tag) async {
    await _db.insertTag(tag);
    _tags.add(tag);
    notifyListeners();
  }
}
