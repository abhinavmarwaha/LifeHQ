import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

class JournalEntryDetails extends StatelessWidget {
  const JournalEntryDetails({
    Key? key,
    required this.entry,
  }) : super(key: key);

  static const routeName = '/details';

  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    final _controller = quill.QuillController(
        document: quill.Document.fromJson(jsonDecode(entry.text)),
        selection: TextSelection.collapsed(offset: 0));

    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyBackButton(),
              Spacer(),
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
            ],
          ),
          if (entry.tags.length != 0)
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          entry.tags[index],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: entry.tags.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Utilities.beautifulDate(entry.date),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Text(
            entry.title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              child: quill.QuillEditor.basic(
                controller: _controller,
                readOnly: true, // true for view only mode
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              entry.locationDisplayName ?? "",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
