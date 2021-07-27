import 'package:flutter/material.dart';
import 'package:lifehq/journal/journal_entry_input.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/journal/widgets/entry_card.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:provider/provider.dart';

class Journal extends StatefulWidget {
  const Journal({Key key}) : super(key: key);

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalService>(
        builder: (context, journalService, child) => Scaffold(
            key: _scaffold,
            drawerScrimColor: Colors.grey.withOpacity(0),
            backgroundColor: Colors.black,
            endDrawer: SafeArea(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: journalService.tags
                          .map<Widget>((e) => Card(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )))
                          .toList() +
                      [
                        Spacer(),
                        GestureDetector(
                          onTap: () =>
                              showTagAddDialog(context, journalService),
                          child: Card(
                            color: Colors.black,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                ),
              ),
            ),
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
                      onTap: () => _scaffold.currentState.openEndDrawer(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tags"),
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

  showTagAddDialog(BuildContext context, JournalService provider) {
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
}
