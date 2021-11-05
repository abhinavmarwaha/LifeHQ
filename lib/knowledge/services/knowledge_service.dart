import 'package:flutter/material.dart';
import 'package:lifehq/knowledge/models/news/news_item.dart';
import 'package:lifehq/knowledge/models/news/news_rss_feed.dart';
import 'package:lifehq/knowledge/models/para/knowledge_bit.dart';
import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';
import 'package:lifehq/knowledge/models/para/knowledge_folder.dart';
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

  List<KnowledgeBit> _bits = [];
  List<KnowledgeBit> bits(KnowledgeCat cat, String folder) => _bits
      .where((element) =>
          element.knowledgeBitType == cat.toInt() &&
          element.folder.compareTo(folder) == 0)
      .toList();
  List<String> _bitTags = [];
  List<String> get bitTags => _bitTags;
  List<KnowledgeFolder> _folders = [];
  List<KnowledgeFolder> folders(KnowledgeCat cat) =>
      _folders.where((element) => element.cat == cat).toList();

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
      _folders = await _db.getFolders();
      _bits = await _db.getBits();
      await updateFeedItems();

      initilised = true;
      notifyListeners();
    }
  }

  // Knowledge Bit

  Future<void> saveBit(KnowledgeBit bit) async {
    int id = await _db.insertBit(bit);
    bit.knowledgeBitId = id;
    _bits.add(bit);
    notifyListeners();
  }

  Future<void> editBit(KnowledgeBit bit) async {
    // TODO
    await _db.editBit(bit);

    notifyListeners();
  }

  Future<void> deleteBit(KnowledgeBit bit) async {
    await _db.deleteBit(bit.knowledgeBitType);
    _principles.remove(bit);
    notifyListeners();
  }

  // Folder

  Future<void> saveFolder(KnowledgeFolder folder) async {
    await _db.insertFolder(folder);
    _folders.add(folder);
    notifyListeners();
  }

  Future<void> editFolder(KnowledgeFolder folder) async {
    await _db.editFolder(folder);

    notifyListeners();
  }

  Future<void> deleteFolder(KnowledgeFolder folder) async {
    // await _db.deleteFolder(folder);
    _folders.remove(folder);

    notifyListeners();
  }

  // Principle

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

  // Quote

  Future<void> saveQuote(String quote) async {
    final _quote = Quote(
      added: DateTime.now(),
      text: quote,
    );
    int id = await _db.insertQuote(_quote);
    _quote.quoteId = id;
    _quotes.add(_quote);

    notifyListeners();
  }

  Future<void> deleteQuote(Quote quote) async {
    await _db.deleteQuote(quote.quoteId!);
    _quotes.remove(quote);

    notifyListeners();
  }

  addQuoteToList(Quote quote, int id) {
    quote.quoteId = id;
    _quotes.add(quote);

    notifyListeners();
  }

  // Rss

  // Feed

  Future<void> saveFeed(NewsRssFeed feed) async {
    print(feed.url);
    int id = await _db.insertRssFeed(feed);
    feed.id = id;
    _feeds.add(feed);
    updateFeedItems();

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
      if (item.bookmarked) {
        _bookmarks.remove(item);
      } else {
        _bookmarks.add(item);
      }
      item.bookmarked = !item.bookmarked;
    }
    if (changeRead) {
      if (item.read) {
        _readFeedItems.remove(item);
        _unreadFeedItems.add(item);
      } else {
        _readFeedItems.add(item);
        _unreadFeedItems.remove(item);
      }
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

  Future<void> updateFeedItems() async {
    for (NewsRssFeed _feed in _feeds) {
      print(_feed.url);
      String FeedBody = (await http.Client().get(Uri.parse(_feed.url))).body;
      if (_feed.atom) {
        AtomFeed atomFeed = new AtomFeed.parse(FeedBody);
        atomFeed.items!.forEach((feedItem) {
          NewsItem item = new NewsItem(
              feedTitle: atomFeed.title ?? "",
              feedID: _feed.id.toString(),
              title: feedItem.title ?? "",
              desc: feedItem.summary ?? "",
              url: feedItem.links![0].href!,
              read: false,
              picURL: "",
              pubDate: feedItem.updated!.toIso8601String(),
              author: feedItem.authors != null
                  ? feedItem.authors!.length == 0
                      ? ""
                      : feedItem.authors![0].name!
                  : "",
              catgry: _feed.tags.length > 0 ? _feed.tags[0] : "All",
              bookmarked: false,
              mediaURL: '');
          _db.hasFeeditem(item).then((value) {
            if (!value) {
              _db.insertRssFeedtem(item);
            }
            _unreadFeedItems.add(item);
          });
        });
      } else {
        RssFeed rssFeed = new RssFeed.parse(FeedBody);

        rssFeed.items!.forEach((feedItem) {
          String url = "";
          if (feedItem.enclosure != null &&
              feedItem.enclosure!.type!.compareTo("image/jpg") == 0)
            url = feedItem.enclosure!.url!;

          NewsItem item = new NewsItem(
              feedTitle: rssFeed.title ?? "",
              feedID: _feed.id.toString(),
              title: feedItem.title ?? "",
              desc: feedItem.description ?? "",
              read: false,
              picURL: url,
              pubDate: feedItem.pubDate!.toIso8601String(),
              author: feedItem.author ?? "",
              catgry: _feed.tags.length > 0 ? _feed.tags[0] : "All",
              bookmarked: false,
              mediaURL: '',
              url: feedItem.link!);

          _db.hasFeeditem(item).then((value) {
            if (!value) {
              _db.insertRssFeedtem(item);
            }
            _unreadFeedItems.add(item);
          });
        });
      }
    }
  }
}
