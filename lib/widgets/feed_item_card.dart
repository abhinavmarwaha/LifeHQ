
import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/models/news/news_item.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedItemCard extends StatelessWidget {
  const FeedItemCard({Key? key, required this.item}) : super(key: key);

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(item.url);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
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
                    padding: const EdgeInsets.all(8.0), child: Text(item.desc)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
