import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:lifehq/journal/journal_entry_details.dart';
import 'package:lifehq/journal/models/journal_entry.dart';

class EntryCard extends StatelessWidget {
  const EntryCard({
    Key? key,
    required this.journalEntry,
  }) : super(key: key);

  final JournalEntry journalEntry;

  @override
  Widget build(BuildContext context) {
    final _controller = quill.QuillController(
        document: quill.Document.fromJson(jsonDecode(journalEntry.text)),
        selection: TextSelection.collapsed(offset: 0));

    final FocusNode _focusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => JournalEntryDetails(
                      entry: journalEntry,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                journalEntry.title,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: quill.QuillEditor(
                    scrollController: ScrollController(),
                    showCursor: false,
                    scrollable: true,
                    focusNode: _focusNode,
                    autoFocus: false,
                    readOnly: true,
                    expands: false,
                    padding: EdgeInsets.zero,
                    controller: _controller,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
