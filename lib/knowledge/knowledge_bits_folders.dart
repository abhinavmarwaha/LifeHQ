import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/knowledge_bits_list.dart';
import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';
import 'package:lifehq/knowledge/models/para/knowledge_folder.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/page_title.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

class KnowledgeBitsFolders extends StatelessWidget {
  const KnowledgeBitsFolders({
    Key? key,
    required this.cat,
  }) : super(key: key);

  static const project = '/project';
  static const area = '/area';
  static const research = '/research';
  static const archive = '/archive';

  final KnowledgeCat cat;

  @override
  Widget build(BuildContext context) {
    return Skeleton(child:
        Consumer<KnowledgeService>(builder: (context, knowledgeService, child) {
      final folders = knowledgeService.folders;

      return Column(
        children: [
          Row(
            children: [
              MyBackButton(),
              PageTitle(
                text: cat.title(),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => KnowledgeBitsList(
                                    cat: cat,
                                    folder: folders(cat)[index],
                                  )));
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            folders(cat)[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ))),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white,
                    ),
                itemCount: folders(cat).length),
          ),
          Center(
            child: GestureDetector(
              onTap: () => _openAddDialog(context, knowledgeService),
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
      );
    }));
  }

  void _openAddDialog(BuildContext context, KnowledgeService knowledgeService) {
    String _folder = "";

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
                                if (_folder.isNotEmpty) {
                                  knowledgeService.saveFolder(
                                      KnowledgeFolder(cat: cat, name: _folder));
                                  Navigator.pop(context);
                                } else {
                                  Utilities.showToast("Can't be empty");
                                }
                              },
                              onChanged: (value) => _folder = value,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Folder Name'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_folder.isNotEmpty) {
                                  knowledgeService.saveFolder(
                                      KnowledgeFolder(cat: cat, name: _folder));
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
