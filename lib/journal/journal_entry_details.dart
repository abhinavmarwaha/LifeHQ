import 'package:flutter/material.dart';
import 'package:lifehq/journal/models/journal_entry.dart';

class JournalEntryDetails extends StatelessWidget {
  const JournalEntryDetails({
    Key key,
    @required this.entry,
  }) : super(key: key);

  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            entry.title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ])));
  }
}
