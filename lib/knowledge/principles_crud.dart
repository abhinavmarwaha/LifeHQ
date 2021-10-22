import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:provider/provider.dart';

class PrincipleCRUD extends StatelessWidget {
  const PrincipleCRUD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Consumer<KnowledgeService>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Principles",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView(
              children: value.principles
                  .map((e) => Row(
                        children: [
                          Text(e.title),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                value.deletePrinciple(e);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.delete),
                              )),
                        ],
                      ))
                  .toList(),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => _openAddDialog(context, value),
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
          ),
        ],
      ),
    ));
  }

  void _openAddDialog(BuildContext context, KnowledgeService knowledgeService) {
    String _princi = "";

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
                            TextFormField(
                              onFieldSubmitted: (value) {
                                if (_princi.isNotEmpty) {
                                  knowledgeService.savePrinciple(_princi);
                                  Navigator.pop(context);
                                } else {
                                  Utilities.showToast("Can't be empty");
                                }
                              },
                              onChanged: (value) => _princi = value,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'tag'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_princi.isNotEmpty) {
                                  knowledgeService.savePrinciple(_princi);
                                  Navigator.pop(context);
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
