import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/models/principle.dart';
import 'package:lifehq/knowledge/models/quote.dart';
import 'package:lifehq/knowledge/services/knowledge_db.dart';

class KnowledgeService with ChangeNotifier {
  static final KnowledgeService instance = KnowledgeService._internal();
  KnowledgeService._internal() {
    _init();
  }
  factory KnowledgeService() {
    return instance;
  }
  bool initilised = false;
  late KnowledgeDB _db;

  List<Principle> _principles = [];
  List<Principle> get principles => _principles;
  List<Quote> _quotes = [];
  List<Quote> get quotes => _quotes;

  Future _init() async {
    if (!initilised) {
      _db = KnowledgeDB();
      _principles = await _db.getPrinciples();
      _quotes = await _db.getQuotes();
      initilised = true;
      notifyListeners();
    }
  }

  Future<void> savePrinciple(String principle) async {
    final prin = Principle(title: principle, added: DateTime.now());
    int id = await _db.insertPrinciple(prin);
    prin.principleId = id;
    _principles.add(prin);
    notifyListeners();
  }
}
