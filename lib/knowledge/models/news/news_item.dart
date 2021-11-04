import 'dart:convert';

class NewsItem {
  final int id;
  final String title;
  final String desc;
  final String picURL;
  final String url;
  final String catgry;
  final String pubDate;
  final String author;
  final String feedID;
  final String mediaURL;
  final String feedTitle;
  bool bookmarked;
  bool read;

  NewsItem({
    required this.id,
    required this.title,
    required this.desc,
    required this.picURL,
    required this.url,
    required this.catgry,
    required this.pubDate,
    required this.author,
    required this.feedID,
    required this.mediaURL,
    required this.feedTitle,
    required this.bookmarked,
    required this.read,
  });

  NewsItem copyWith({
    int? id,
    String? title,
    String? desc,
    String? picURL,
    String? url,
    String? catgry,
    String? pubDate,
    String? author,
    String? feedID,
    String? mediaURL,
    String? feedTitle,
    bool? bookmarked,
    bool? read,
  }) {
    return NewsItem(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      picURL: picURL ?? this.picURL,
      url: url ?? this.url,
      catgry: catgry ?? this.catgry,
      pubDate: pubDate ?? this.pubDate,
      author: author ?? this.author,
      feedID: feedID ?? this.feedID,
      mediaURL: mediaURL ?? this.mediaURL,
      feedTitle: feedTitle ?? this.feedTitle,
      bookmarked: bookmarked ?? this.bookmarked,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'picURL': picURL,
      'url': url,
      'catgry': catgry,
      'pubDate': pubDate,
      'author': author,
      'feedID': feedID,
      'mediaURL': mediaURL,
      'feedTitle': feedTitle,
      'bookmarked': bookmarked,
      'read': read,
    };
  }

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return NewsItem(
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
      picURL: map['picURL'],
      url: map['url'],
      catgry: map['catgry'],
      pubDate: map['pubDate'],
      author: map['author'],
      feedID: map['feedID'],
      mediaURL: map['mediaURL'],
      feedTitle: map['feedTitle'],
      bookmarked: map['bookmarked'],
      read: map['read'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsItem.fromJson(String source) =>
      NewsItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsItem(id: $id, title: $title, desc: $desc, picURL: $picURL, url: $url, catgry: $catgry, pubDate: $pubDate, author: $author, feedID: $feedID, mediaURL: $mediaURL, feedTitle: $feedTitle, bookmarked: $bookmarked, read: $read)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsItem &&
        other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.picURL == picURL &&
        other.url == url &&
        other.catgry == catgry &&
        other.pubDate == pubDate &&
        other.author == author &&
        other.feedID == feedID &&
        other.mediaURL == mediaURL &&
        other.feedTitle == feedTitle &&
        other.bookmarked == bookmarked &&
        other.read == read;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        picURL.hashCode ^
        url.hashCode ^
        catgry.hashCode ^
        pubDate.hashCode ^
        author.hashCode ^
        feedID.hashCode ^
        mediaURL.hashCode ^
        feedTitle.hashCode ^
        bookmarked.hashCode ^
        read.hashCode;
  }
}
