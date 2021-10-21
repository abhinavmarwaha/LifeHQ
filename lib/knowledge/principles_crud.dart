import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/skeleton.dart';
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
              children: value.principles.map((e) => Text(e.title)).toList(),
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
        builder: (ctx) => Dialog(
              child: Container(
                width: 12,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: (value) =>
                          knowledgeService.savePrinciple(value),
                      onChanged: (value) => _princi = value,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Type"),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => knowledgeService.savePrinciple(_princi),
                        child: SizedBox(
                          width: 120,
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
