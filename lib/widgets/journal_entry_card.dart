import 'package:flutter/material.dart';
import 'package:lifehq/journal/models/journal_entry.dart';

class JournalEntryCard extends StatelessWidget {
  const JournalEntryCard({Key? key, required this.journalEntry})
      : super(key: key);

  final JournalEntry journalEntry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(journalEntry.title)],
            ),
          ),
        ),
      ),
    );
  }
}
