import 'package:feed_finder/feed_finder.dart';
import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/models/news/news_rss_feed.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:lifehq/widgets/feed_item_card.dart';
import 'package:lifehq/widgets/selected_heading.dart';
import 'package:lifehq/widgets/unselected_handing.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Feeds extends StatefulWidget {
  Feeds({Key? key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  String? selectedTag;
  bool read = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<KnowledgeService>(
      builder: (context, knowledgeService, child) => Scaffold(
        key: _scaffold,
        drawerScrimColor: Colors.grey.withOpacity(0),
        backgroundColor: Colors.black,
        endDrawer: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: knowledgeService.feedTags
                      .map<Widget>((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTag = selectedTag != null &&
                                        selectedTag!.compareTo(e) == 0
                                    ? null
                                    : e;
                              });
                            },
                            child: Card(
                                color: selectedTag != null &&
                                        selectedTag!.compareTo(e) == 0
                                    ? Colors.red
                                    : Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ))
                      .toList() +
                  [
                    Spacer(),
                    GestureDetector(
                      onTap: () => showTagAddDialog(context, knowledgeService),
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
          child: Container(
            color: Color(0xffe0e0e0),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyBackButton(),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                read = true;
                              });
                            },
                            child: read
                                ? SelectedHeading(text: "Read")
                                : UnselectedHeading(text: "Read"),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                read = false;
                              });
                            },
                            child: !read
                                ? SelectedHeading(text: "Unread")
                                : UnselectedHeading(text: "Unread"),
                          ),
                          Spacer(),
                          Icon(Icons.bookmark),
                          SizedBox(
                            width: 28,
                          ),
                          GestureDetector(
                            onTap: () =>
                                _scaffold.currentState!.openEndDrawer(),
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
                          children: (read
                                  ? knowledgeService.readFeedItems
                                  : knowledgeService.unreadFeedItems)
                              .where((element) => selectedTag == null
                                  ? true
                                  : element.catgry.compareTo(selectedTag!) == 0)
                              .map((feedItem) => FeedItemCard(
                                    item: feedItem,
                                  ))
                              .toList(),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showFeedAddDialog(context, knowledgeService);
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showFeedAddDialog(BuildContext context, KnowledgeService provider) {
    final feedUrl = TextEditingController();

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
                              controller: feedUrl,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'FeedUrl',
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (feedUrl.text.isNotEmpty) {
                                  addFeed(feedUrl.text, "", false, false);
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

  addFeed(String url, String catgry, bool atom, bool second) async {
    try {
      if (catgry.compareTo("") == 0) catgry = "All";
      final response = await http.Client().get(Uri.parse(url));
      NewsRssFeed rss;
      if (atom) {
        AtomFeed atomFeed = AtomFeed.parse(response.body);
        rss = NewsRssFeed(
            title: atomFeed.title ?? "",
            desc: atomFeed.subtitle ?? "",
            picURL: atomFeed.logo ?? "",
            catgry: catgry,
            url: url,
            author: atomFeed.authors == null ? "" : atomFeed.authors![0].name!,
            lastBuildDate: atomFeed.updated!.toIso8601String(),
            atom: atom,
            id: -1);
      } else {
        RssFeed rssFeed = RssFeed.parse(response.body);
        rss = NewsRssFeed(
            title: rssFeed.title ?? "",
            desc: rssFeed.description ?? "",
            picURL: rssFeed.image != null ? rssFeed.image!.url! : "",
            catgry: catgry,
            url: url,
            author: rssFeed.author ?? "",
            lastBuildDate: rssFeed.lastBuildDate ?? "",
            atom: atom);
      }

      KnowledgeService.instance.saveFeed(rss).then((value) {
        Navigator.of(context).pop();
      });
    } catch (e) {
      if (!second) {
        String txt = (await FeedFinder.scrape(url))[0];
        print(txt);
        addFeed(txt, catgry, atom, true);
      }
    }
  }

  showTagAddDialog(BuildContext context, KnowledgeService provider) {
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
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'tag'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (tagText.text.isNotEmpty) {
                                  provider
                                      .saveCat(tagText.text)
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
