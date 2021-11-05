import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lifehq/knowledge/models/news/news_item.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/knowledge/zen.dart';
import 'package:lifehq/services/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedItemCard extends StatelessWidget {
  const FeedItemCard({Key? key, required this.item}) : super(key: key);

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!item.read)
          Provider.of<KnowledgeService>(context, listen: false)
              .changeItem(item, false, true);
        Provider.of<SettingsProvider>(context, listen: false).zenBool
            ? Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => Zen(item.url)))
            : launch(item.url);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item.title,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Provider.of<KnowledgeService>(context, listen: false)
                          .changeItem(item, true, false);
                    },
                    child: Icon(
                      item.bookmarked
                          ? Icons.bookmark_added
                          : Icons.bookmark_add,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(data: item.desc)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
