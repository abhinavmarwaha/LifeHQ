import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/models/news/news_item.dart';
import 'package:lifehq/knowledge/models/news/news_rss_feed.dart';
import 'package:lifehq/knowledge/models/para/knowledge_bit.dart';
import 'package:lifehq/knowledge/models/principle.dart';
import 'package:lifehq/knowledge/models/quote.dart';
import 'package:lifehq/knowledge/services/knowledge_db.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class KnowledgeService with ChangeNotifier {
  static final KnowledgeService instance = KnowledgeService._internal();
  KnowledgeService._internal() {
    _init();
  }
  factory KnowledgeService() {
    return instance;
  }
  bool initilised = false;
  late KnowledgeDB _db;

  List<KnowledgenBit> _bits = [];
  List<KnowledgenBit> get bits => _bits;

  List<Principle> _principles = [];
  List<Principle> get principles => _principles;
  List<Quote> _quotes = [];
  List<Quote> get quotes => _quotes;

  List<NewsRssFeed> _feeds = [];
  List<NewsRssFeed> get feeds => _feeds;
  List<NewsItem> _readFeedItems = [];
  List<NewsItem> get readFeedItems => _readFeedItems;
  List<NewsItem> _unreadFeedItems = [];
  List<NewsItem> get unreadFeedItems => _unreadFeedItems;
  List<NewsItem> _bookmarks = [];
  List<NewsItem> get bookmarks => _bookmarks;
  List<String> _feedTags = [];
  List<String> get feedTags => _feedTags;

  Future _init() async {
    if (!initilised) {
      _db = KnowledgeDB();
      _principles = await _db.getPrinciples();
      _quotes = await _db.getQuotes();
      _feeds = await _db.getRssFeeds("All");
      _readFeedItems = await _db.getUnreadRssItems("All");
      _unreadFeedItems = await _db.getReadRssItems("All");
      _bookmarks = await _db.getReadRssItems("All");
      _bits = await _db.getBits();

      initilised = true;
      notifyListeners();
    }
  }

  // Knowledge Bit

  Future<void> saveBit(KnowledgenBit bit) async {
    int id = await _db.insertBit(bit);
    bit.knowledgenBitId = id;
    _bits.add(bit);
    notifyListeners();
  }

  Future<void> editBit(KnowledgenBit bit) async {
    // TODO
    await _db.editBit(bit);

    notifyListeners();
  }

  Future<void> deleteBit(KnowledgenBit bit) async {
    await _db.deleteBit(bit.knowledgenBitId);
    _principles.remove(bit);
    notifyListeners();
  }

  // Priciple

  Future<void> savePrinciple(String principle) async {
    final prin = Principle(title: principle, added: DateTime.now());
    int id = await _db.insertPrinciple(prin);
    prin.principleId = id;
    _principles.add(prin);
    notifyListeners();
  }

  Future<void> deletePrinciple(Principle principle) async {
    await _db.deletePrinciple(principle.principleId!);
    _principles.remove(principle);
    notifyListeners();
  }

  addPrincipleToList(Principle prin, int id) {
    prin.principleId = id;
    _principles.add(prin);

    notifyListeners();
  }

  // Rss

  // Feed

  Future<void> saveFeed(NewsRssFeed feed) async {
    int id = await _db.insertRssFeed(feed);
    feed.id = id;
    _feeds.add(feed);

    notifyListeners();
  }

  Future<void> deleteFeed(NewsRssFeed feed) async {
    await _db.deleteRssFeed(feed.id!);
    _feeds.remove(feed);

    notifyListeners();
  }

  // RssItems

  Future<void> changeItem(
      NewsItem item, bool changeBookmark, bool changeRead) async {
    if (changeBookmark) {
      item.bookmarked = !item.bookmarked;
      _bookmarks.add(item);
    }
    if (changeRead) {
      item.read = !item.read;
    }
    await _db.editRssFeedItem(item);

    notifyListeners();
  }

  Future<void> deleteRssItem(NewsItem item) async {
    await _db.deleteRssItem(item);
    if (item.read) {
      _readFeedItems.remove(item);
    } else {
      _unreadFeedItems.remove(item);
    }

    if (item.bookmarked) {
      _bookmarks.remove(item);
    }

    notifyListeners();
  }

  // Categories

  Future<void> saveCat(String cat) async {
    await _db.insertCategory(cat);
    _feedTags.add(cat);

    notifyListeners();
  }

  Future<void> editCat(String cat, String prevCat) async {
    // TODO
    await _db.editCategory(prevCat, cat);
    _feedTags.add(cat);
    _feedTags.remove(prevCat);

    notifyListeners();
  }

  Future<void> deleteCat(NewsRssFeed feed) async {
    await _db.deleteRssFeed(feed.id!);
    _feeds.remove(feed);

    notifyListeners();
  }

  // Update Rss Items

  // Future<void> updateFeedItems() async {
  //   for (NewsRssFeed _feed in _feeds) {
  //     print(_feed.url);
  //     String FeedBody = (await http.Client().get(Uri.parse(_feed.url))).body;
  //     if (_feed.atom) {
  //       AtomFeed atomFeed = new AtomFeed.parse(FeedBody);
  //       atomFeed.items.forEach((feedItem) {
  //         if (cat.compareTo(_selectedCat) == 0 && !_readUI && !_bookmarkUI) {
  //           CRssFeedItem item = new CRssFeedItem(
  //               feedTitle: atomFeed.title,
  //               feedID: feed.id.toString(),
  //               title: feedItem.title,
  //               desc: feedItem.summary == null ? "" : feedItem.summary,
  //               url: feedItem.links[0].href,
  //               read: false,
  //               picURL: "",
  //               pubDate: feedItem.updated.toIso8601String(),
  //               author: feedItem.authors.length == 0
  //                   ? ""
  //                   : feedItem.authors[0].name,
  //               catgry: cat,
  //               bookmarked: false);
  //           _dbHelper.hasFeeditem(item, rssItems).then((value) {
  //             if (!value) {
  //               _feeditems.add(item);
  //               _dbHelper.insertRssFeedtem(item, rssItems);
  //             }
  //           });
  //         }
  //       });
  //     } else {
  //       RssFeed rssFeed = new RssFeed.parse(FeedBody);

  //       rssFeed.items!.forEach((feedItem) {
  //         String url = "";
  //         if (feedItem.enclosure != null &&
  //             feedItem.enclosure.type.compareTo("image/jpg") == 0)
  //           url = feedItem.enclosure.url;
  //         String feedUrl;
  //         feedUrl = feedItem.link;

  //         NewsItem item = new NewsItem(
  //             feedTitle: rssFeed.title,
  //             feedID: feed.id.toString(),
  //             title: feedItem.title,
  //             desc: feedItem.description,
  //             url: feedUrl,
  //             read: false,
  //             picURL: url,
  //             pubDate: feedItem.pubDate.toIso8601String(),
  //             author: feedItem.author,
  //             catgry: cat,
  //             bookmarked: false);
  //       });
  //     }
  //   }
  // }
}
