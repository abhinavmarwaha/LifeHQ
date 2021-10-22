import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:provider/provider.dart';

class JournalEntryDetails extends StatelessWidget {
  const JournalEntryDetails({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Provider.of<JournalService>(context, listen: false)
                    .deleteJournalEntry(entry)
                    .then((value) => Navigator.of(context).pop());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.delete),
              )),
          if (entry.tags.length != 0)
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entry.tags[index],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  itemCount: entry.tags.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Utilities.beautifulDate(entry.date),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              entry.locationDisplayName ?? "",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Text(
            entry.title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Html(
            data: entry.text,
          ),
        ],
      ),
    );
  }
}
