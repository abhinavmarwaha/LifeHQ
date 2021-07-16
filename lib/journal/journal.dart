import 'package:flutter/material.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/routine/routine_details.dart';
import 'package:provider/provider.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Text(
              "Journal",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Consumer<JournalService>(
              builder: (context, journalService, child) => Expanded(
                child: ListView(
                  children: journalService.entries
                      .map((journalEntry) =>
                          JournalEntryCard(journalEntry: journalEntry))
                      .toList(),
                ),
              ),
            )
          ],
        )));
  }
}

class EntryCard extends StatelessWidget {
  const EntryCard({
    Key key,
    @required this.journalEntry,
  }) : super(key: key);

  final JournalEntry journalEntry;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Column(
        children: [Text(journalEntry.title)],
      ),
    );
  }
}
