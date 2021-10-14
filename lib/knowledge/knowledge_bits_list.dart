import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/models/knowledge_cat.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/page_title.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class KnowledgeBitsList extends StatelessWidget {
  const KnowledgeBitsList({
    Key key,
    @required this.cat,
  }) : super(key: key);

  final KnowledgeCat cat;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [
        PageTitle(
          text: cat.title(),
        ),
        Consumer<KnowledgeService>(
          builder: (context, knowledgeService, child) => ListView.separated(
              itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white,
                  ),
              separatorBuilder: (context, index) =>
                  Text(knowledgeService.quotes[index].text),
              itemCount: knowledgeService.quotes.length),
        ),
      ],
    ));
  }
}
