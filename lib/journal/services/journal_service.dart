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
  JournalDB _db;

  List<JournalEntry> _entries;
  List<JournalEntry> get entries => _entries;

  Future _init() async {
    if (!initilised) {
      _db = JournalDB();
      _entries = await _db.getEntries();
      initilised = true;
      notifyListeners();
    }
  }
}
