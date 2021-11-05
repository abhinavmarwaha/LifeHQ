import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/knowledge_bit_input.dart';
import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';
import 'package:lifehq/knowledge/models/para/knowledge_folder.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/page_title.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class KnowledgeBitsList extends StatelessWidget {
  const KnowledgeBitsList({
    Key? key,
    required this.cat,
    required this.folder,
  }) : super(key: key);

  final KnowledgeCat cat;
  final KnowledgeFolder folder;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [
        Row(
          children: [
            MyBackButton(),
            PageTitle(
              text: folder.name,
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: Consumer<KnowledgeService>(
              builder: (context, knowledgeService, child) {
            final bits = knowledgeService.bits(cat, folder.name);

            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final _controller = quill.QuillController(
                      document:
                          quill.Document.fromJson(jsonDecode(bits[index].text)),
                      selection: TextSelection.collapsed(offset: 0));
                  final FocusNode _focusNode = FocusNode();

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bits[index].title,
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
                  );
                },
                itemCount: bits.length);
          }),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          KnowledgeBitInput(cat: cat, folder: folder)));
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
    ));
  }
}
