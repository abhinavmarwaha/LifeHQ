import 'dart:convert';

class NewsRssFeed {
  int? id;
  final String title;
  final String desc;
  final String catgry;
  final String picURL;
  final String url;
  final String lastBuildDate;
  final String author;
  final bool atom;
  final List<String> tags;

  NewsRssFeed(
      {this.id,
      required this.title,
      required this.desc,
      required this.catgry,
      required this.picURL,
      required this.url,
      required this.lastBuildDate,
      required this.author,
      required this.atom,
      required this.tags});

  NewsRssFeed copyWith({
    int? id,
    String? title,
    String? desc,
    String? catgry,
    String? picURL,
    String? url,
    String? lastBuildDate,
    String? author,
    bool? atom,
    int? feedId,
    List<String>? tags,
  }) {
    return NewsRssFeed(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        catgry: catgry ?? this.catgry,
        picURL: picURL ?? this.picURL,
        url: url ?? this.url,
        lastBuildDate: lastBuildDate ?? this.lastBuildDate,
        author: author ?? this.author,
        atom: atom ?? this.atom,
        tags: tags ?? this.tags);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'catgry': catgry,
      'picURL': picURL,
      'url': url,
      'lastBuildDate': lastBuildDate,
      'author': author,
      'atom': atom ? 1 : 0,
      'tags': tags.join(",")
    };
  }

  factory NewsRssFeed.fromMap(Map<String, dynamic> map) {
    return NewsRssFeed(
        id: map['id'],
        title: map['title'],
        desc: map['desc'],
        catgry: map['catgry'],
        picURL: map['picURL'],
        url: map['url'],
        lastBuildDate: map['lastBuildDate'],
        author: map['author'],
        atom: map['atom'] == 1,
        tags: map['tags'].toString().split(","));
  }

  String toJson() => json.encode(toMap());

  factory NewsRssFeed.fromJson(String source) =>
      NewsRssFeed.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsRssFeed(id: $id, title: $title, desc: $desc, catgry: $catgry, picURL: $picURL, url: $url, lastBuildDate: $lastBuildDate, author: $author, atom: $atom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsRssFeed &&
        other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.catgry == catgry &&
        other.picURL == picURL &&
        other.url == url &&
        other.lastBuildDate == lastBuildDate &&
        other.author == author &&
        other.atom == atom;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        catgry.hashCode ^
        picURL.hashCode ^
        url.hashCode ^
        lastBuildDate.hashCode ^
        author.hashCode ^
        atom.hashCode;
  }
}
