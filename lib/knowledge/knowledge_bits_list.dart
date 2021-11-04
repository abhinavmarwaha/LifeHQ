import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/knowledge_bit_input.dart';
import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/page_title.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

class KnowledgeBitsList extends StatelessWidget {
  const KnowledgeBitsList({
    Key? key,
    required this.cat,
  }) : super(key: key);

  final KnowledgeCat cat;

  static const project = '/project';
  static const area = '/area';
  static const research = '/research';
  static const archive = '/archive';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [
        Row(
          children: [
            MyBackButton(),
            PageTitle(
              text: cat.title(),
            ),
          ],
        ),
        Expanded(
          child: Consumer<KnowledgeService>(
              builder: (context, knowledgeService, child) {
            final bits = knowledgeService.bits(cat);

            return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white,
                    ),
                separatorBuilder: (context, index) => Text(
                      bits[index].text,
                      style: TextStyle(color: Colors.white),
                    ),
                itemCount: bits.length);
          }),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => KnowledgeBitInput(
                            cat: cat,
                          )));
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
