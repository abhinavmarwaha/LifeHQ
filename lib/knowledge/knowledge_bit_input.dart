import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:lifehq/knowledge/models/para/knowledge_bit.dart';
import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';
import 'package:lifehq/knowledge/models/para/knowledge_folder.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:provider/provider.dart';

class KnowledgeBitInput extends StatefulWidget {
  const KnowledgeBitInput({
    Key? key,
    required this.cat,
    required this.folder,
  }) : super(key: key);

  static const routeName = '/add-bit';

  final KnowledgeCat cat;
  final KnowledgeFolder folder;

  @override
  _KnowledgeBitInputState createState() => _KnowledgeBitInputState();
}

class _KnowledgeBitInputState extends State<KnowledgeBitInput> {
  quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final _dateTime = DateTime.now();

  String title = "";
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Consumer<KnowledgeService>(
            builder: (context, knowledgeService, child) => SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel)),
                      ],
                    ),
                    if (knowledgeService.bitTags.length != 0)
                      SizedBox(
                        height: 48,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedTags.contains(
                                        knowledgeService.bitTags[index]))
                                      selectedTags.remove(
                                          knowledgeService.bitTags[index]);
                                    else
                                      selectedTags
                                          .add(knowledgeService.bitTags[index]);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: selectedTags.contains(
                                                    knowledgeService
                                                        .bitTags[index])
                                                ? Colors.white
                                                : Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          knowledgeService.bitTags[index],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: selectedTags.contains(
                                                      knowledgeService
                                                          .bitTags[index])
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                          itemCount: knowledgeService.bitTags.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(Utilities.beautifulDate(_dateTime)),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => title = value,
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 24),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: "Title"),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              Provider.of<KnowledgeService>(context,
                                      listen: false)
                                  .saveBit(KnowledgeBit(
                                      added: _dateTime,
                                      tags: selectedTags,
                                      lastModified: DateTime.now(),
                                      text: jsonEncode(_controller.document
                                          .toDelta()
                                          .toJson()),
                                      title: title,
                                      folder: widget.folder.name,
                                      knowledgeBitType: widget.cat.toInt()))
                                  .then((value) => Navigator.pop(context));
                            },
                            child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 50,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                            quill.QuillToolbar.basic(controller: _controller),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: quill.QuillEditor(
                          scrollController: ScrollController(),
                          scrollable: true,
                          focusNode: _focusNode,
                          autoFocus: false,
                          readOnly: false,
                          placeholder: 'Add content',
                          expands: false,
                          padding: EdgeInsets.zero,
                          controller: _controller,
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
