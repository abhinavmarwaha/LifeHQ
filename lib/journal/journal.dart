import 'package:flutter/material.dart';
import 'package:lifehq/journal/journal_entry_input.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/journal/widgets/entry_card.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:provider/provider.dart';

class Journal extends StatelessWidget {
  const Journal({Key key}) : super(key: key);

  showTagAddDialog(
    BuildContext context,
    JournalService provider,
  ) {
    final tagText = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    height: 120,
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tagText,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'tag'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (tagText.text.isNotEmpty) {
                                  provider
                                      .insertTag(tagText.text)
                                      .then((value) => Navigator.pop(context));
                                } else {
                                  Utilities.showToast("Can't be empty");
                                }
                              },
                              child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Add",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )),
                            )
                          ],
                        ))));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalService>(
        builder: (context, journalService, child) => Scaffold(
            endDrawer: Column(
              children:
                  journalService.tags.map<Widget>((e) => Text(e)).toList(),
            ),
            backgroundColor: Colors.black,
            body: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Journal",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => showTagAddDialog(context, journalService),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Add Tag"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView(
                    children: journalService.entries
                        .map((journalEntry) =>
                            EntryCard(journalEntry: journalEntry))
                        .toList(),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => JournalEntryInput()));
                    },
                    child: SizedBox(
                      width: 120,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))));
  }
}
